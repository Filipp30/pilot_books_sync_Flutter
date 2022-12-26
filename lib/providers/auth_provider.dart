import 'package:flutter/cupertino.dart';
import 'package:pilot_books_sync_mobiel/dto/http/registration_response_dto.dart';
import 'package:pilot_books_sync_mobiel/models/user_registration.dart';
import 'package:pilot_books_sync_mobiel/services/api_client.dart';

class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;

  bool get isAuth {
    return true;
  }

  Future<RegistrationResponseDto> registration(UserRegistration user) async {
    final response = await ApiClient().post(
        endpoint: Endpoint.authRegistration,
        body: user.body
    );
    
    return RegistrationResponseDto.fromResponse(response);
  }


}