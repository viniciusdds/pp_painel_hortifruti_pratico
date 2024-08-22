import 'package:file_picker/file_picker.dart';

class UserModelRequest {
  String name;
  String email;
  String? password;
  PlatformFile? logo;
  int online;

  UserModelRequest({
    required this.name,
    required this.email,
    this.password,
    this.logo,
    this.online = 0
  });

  // Método para converter o objeto UserModel em um Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'email': email,
      'logo': logo,
      'online': online,
      if(password != null && password!.isNotEmpty)
        'password': password
    };
  }

  factory UserModelRequest.fromJson(Map<String, dynamic> json) => UserModelRequest(
      name: json['nome'],
      email: json['email'],
      logo: json['logo'],
      online: json['online'],
  );
}