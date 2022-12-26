import 'dart:convert';
import 'package:http/http.dart';

class LoginResponseDto {
  final bool success;
  final String message;

  const LoginResponseDto._({required this.success, required this.message});

  static LoginResponseDto fromResponse(Response response) {

    final result = jsonDecode(response.body) as Map<String, dynamic>;

    final List<String> messages = [];
    if (result['message'] != null) {
      messages.add(result['message']);
    }

    final Map errors;
    if (result['errors'] != null) {
      errors = result['errors'] as Map<String, dynamic>;
      errors.forEach((key, value) {
        messages.add(value[0]);
      });
    }

    if ((result['token'] != null) && (response.statusCode == 200)) {
      print('Token exists and need to be saved : ' + result['token']);
      return const LoginResponseDto._(
        success: true,
        message: 'Success login',
      );
    }

    return LoginResponseDto._(
      success: response.statusCode == 200 ? true : false,
      message: messages.join("\n"),
    );
  }
}