
String? validateName(String? value) {
  final nameExp = RegExp(r'^[A-Za-z]+$');
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (!nameExp.hasMatch(value)) {
    return 'Enter alphabetical characters';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (!value.contains('@')) {
    return 'Email form invalid';
  } else if (!value.contains('.')) {
    return 'Email form invalid';
  }  
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (value.length < 6) {
    return 'Must contain min 6 characters';
  }
  return null;
}