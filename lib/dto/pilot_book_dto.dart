import 'dart:convert';

import 'package:http/http.dart';

class PilotBookDto {
  final String? text;
  final String date;
  final String? departurePlace;
  final String? departureTime;
  final String? arrivalPlace;
  final String arrivalTime;
  final String? aircraftModel;
  final String? aircraftRegistration;
  final Map<String, String>? errors;

  const PilotBookDto._({
    this.text,
    required this.date,
    this.departurePlace,
    this.departureTime,
    this.arrivalPlace,
    required this.arrivalTime,
    this.aircraftModel,
    this.aircraftRegistration,
    this.errors
  });

  static PilotBookDto fromResponse(Response response) {
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    return PilotBookDto._(
      text: null,
      date: result['date'],
      departurePlace: null,
      departureTime: null,
      arrivalPlace: null,
      arrivalTime: result['arrivalTime'],
      aircraftModel: null,
      aircraftRegistration: null,
      errors: null
    );

  }
}

// [{"message": "Departure place is not valid.", "departure_place": "EBFM"}]