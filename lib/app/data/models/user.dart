class UserModel {
  int userId;
  String name;
  String email;
  String? logo;
  int online;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.logo,
    this.online = 0
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['id_user'],
    name: json['nome'],
    email: json['email'],
    logo: json['logo'],
    online: json['online'],
  );
}