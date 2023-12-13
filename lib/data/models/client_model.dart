import 'dart:convert';

class ClientModel {
  int id;
  String username;
  String password;
  String name;
  String last_name;
  String email;
  String movil;
  String ci;
  ClientModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.last_name,
    required this.email,
    required this.movil,
    required this.ci,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'last_name': last_name,
      'email': email,
      'movil': movil,
      'ci': ci,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      last_name: map['last_name'] ?? '',
      email: map['email'] ?? '',
      movil: map['movil'] ?? '',
      ci: map['ci'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source));
}
