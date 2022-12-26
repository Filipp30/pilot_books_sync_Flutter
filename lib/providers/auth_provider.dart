import 'package:flutter/cupertino.dart';
import 'package:pilot_books_sync_mobiel/dto/user_login_dto.dart';
import 'package:pilot_books_sync_mobiel/dto/user_registration_dto.dart';
import 'package:pilot_books_sync_mobiel/services/api_client.dart';
import '../dto/login_response_dto.dart';
import '../dto/registration_response_dto.dart';

class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;

  bool get isAuth {
    return true;
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

    return LoginResponseDto.fromResponse(response);
  }
}