
class UserRegistration {
  String name;
  String email;
  String phone;
  String password;
  String confirmation;

  UserRegistration({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmation
  });

  Map<String, String> get body => {
    'name': name,
    'email': email,
    'phone_number': phone,
    'password': password,
    'password_confirmation': confirmation
  };
}