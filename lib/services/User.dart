class User {
  String email;
  String password;
  String role;

  User({ required this.email, required this.password, required this.role});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
