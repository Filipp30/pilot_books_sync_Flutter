import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum Endpoint {
  authRegistration,
  login,
  logout,
  user,
}

class ApiClient {

  static final Map<Endpoint, String> _paths = {
    Endpoint.authRegistration: 'auth/registration',
    Endpoint.login: 'auth/login',
    Endpoint.logout: 'auth/logout',
    Endpoint.user: 'auth/user'
  };

  static const String _host = 'https://da56-212-239-155-71.ngrok.io/api/';

  Future<dynamic> post({required Endpoint endpoint, required Map<String, String> body}) async {
    final Uri url = Uri.parse(_host + _paths[endpoint]!);

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      return await http.post(
          url,
          body: body,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
    } on SocketException catch(_) {
      throw Exception('Problem with internet connection');
    } on HttpException catch (_) {
      throw Exception('Server error. Please contact development team: filipp-tts@outlook.com');
    } catch (_) {
      throw Exception('Server error. Please contact development team: filipp-tts@outlook.com');
    }
  }

  Future<dynamic> get({required Endpoint endpoint}) async {
    final Uri url = Uri.parse(_host + _paths[endpoint]!);

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      return await http.get(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
    } on SocketException catch(_) {
      throw Exception('Problem with internet connection');
    } on HttpException catch (_) {
      throw Exception('Server error. Please contact development team: filipp-tts@outlook.com');
    } catch (_) {
      throw Exception('Server error. Please contact development team: filipp-tts@outlook.com');
    }
  }
}