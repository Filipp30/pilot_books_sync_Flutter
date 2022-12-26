import 'dart:io';
import 'package:http/http.dart' as http;

enum Endpoint {
  authRegistration,
  login
}

class ApiClient {

  static final Map<Endpoint, String> _paths = {
    Endpoint.authRegistration: 'auth/registration',
    Endpoint.login: 'auth/login',
  };

  static const String _host = 'https://da56-212-239-155-71.ngrok.io/api/';

  Future<dynamic> post({required Endpoint endpoint, required Map<String, String> body}) async {
    final Uri url = Uri.parse(_host + _paths[endpoint]!);
    final String key = 'somme api key';

    try {
      return await http.post(
          url,
          body: body,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${key}'
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