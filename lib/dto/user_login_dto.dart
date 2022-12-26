class UserLoginDto {
  String email;
  String password;

  UserLoginDto({
    required this.email,
    required this.password,
  });

  Map<String, String> get body => {
    'email': email,
    'password': password,
  };
}