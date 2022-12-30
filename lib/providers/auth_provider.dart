import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pilot_books_sync_mobiel/dto/user_login_dto.dart';
import 'package:pilot_books_sync_mobiel/dto/user_registration_dto.dart';
import 'package:pilot_books_sync_mobiel/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dto/login_response_dto.dart';
import '../dto/registration_response_dto.dart';

class AuthProvider with ChangeNotifier {
  static bool isAuthenticated = false;

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('token')) {
      isAuthenticated = false;
      notifyListeners();
    } else {
      final response = await ApiClient().get(endpoint: Endpoint.user);

      if (response.statusCode == 401) {
        prefs.remove('token');
        prefs.clear();
        isAuthenticated = false;
        notifyListeners();

      } else if (response.statusCode == 200) {
        isAuthenticated = true;
        notifyListeners();
      }

      throw Exception('AutoLogin failed.');
    }
  }

  Future<RegistrationResponseDto> registration(UserRegistrationDto dto) async {
    final response = await ApiClient().post(
        endpoint: Endpoint.authRegistration,
        body: dto.body
    );
    
    return RegistrationResponseDto.fromResponse(response);
  }

  Future<LoginResponseDto> login(UserLoginDto dto) async {
    final response = await ApiClient().post(
        endpoint: Endpoint.login,
        body: dto.body
    );
    final String? token = jsonDecode(response.body)?['token'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await tryAutoLogin();
    }

    return LoginResponseDto.fromResponse(response);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await ApiClient().get(endpoint: Endpoint.logout);
    if (response.statusCode == 401 || response.statusCode == 200) {
      prefs.remove('token');
      prefs.clear();
      isAuthenticated = false;
      notifyListeners();
      return;
    }

    throw Exception('Logout failed.');
  }
}