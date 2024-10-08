class UserModel {
  int? userId;
  String name;
  String email;
  String? password;
  String? logo;
  int online;

  UserModel({
    this.userId,
    required this.name,
    required this.email,
    this.password,
    this.logo,
    this.online = 0
  });

  // Método para converter o objeto UserModel em um Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'id_user': userId,
      'nome': name,
      'email': email,
      'senha': password,
      'logo': logo,
      'online': online,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['id_user'],
    name: json['nome'],
    email: json['email'],
    logo: json['logo'],
    online: json['online'],
  );
}