class UserProfileRequestModel {

  String name;
  String email;
  String? password;

  UserProfileRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'nome': name,
    'email': email,
    if (password != null && password!.isNotEmpty)
      'password': password,
  };
}