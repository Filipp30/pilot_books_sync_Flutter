import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:pilot_books_sync_mobiel/services/api_client.dart';
import '../dto/pilot_book_dto.dart';

class PilotBookProvider with ChangeNotifier{

  final AuthProvider? authProvider;
  PilotBookProvider(this.authProvider);

  List<PilotBookDto> _records = [];

  // Future<List<PilotBookDto>>
  Future<dynamic> getAll() async {
    final response = await ApiClient().get(endpoint: Endpoint.getPilotBookAll, params: {'type':'ULM'});

    if (response.statusCode == 401) {
      authProvider?.tryAutoLogin();
      return 401;
    }

    print(jsonDecode(response.body));
    return [];

  }
}