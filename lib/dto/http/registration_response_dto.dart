import 'dart:convert';
import 'package:http/http.dart';

class RegistrationResponseDto {
  final bool success;
  final String message;
  const RegistrationResponseDto._({required this.success, required this.message});

  static RegistrationResponseDto fromResponse(Response response) {

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

    return RegistrationResponseDto._(
        success: response.statusCode == 200 ? true : false,
        message: messages.join("\n")
    );
  }
}