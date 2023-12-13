import 'dart:convert';

class CompanyModel {
  int id;
  String company_name;
  String name;
  String last_name;
  String ci;

  /*
  Type: enum
  [Mipyme, TCP, Estatal]
  */
  String type;
  String email;
  String company_code;
  String movil;
  String username;
  String password;
  CompanyModel({
    required this.id,
    required this.company_name,
    required this.name,
    required this.last_name,
    required this.ci,
    required this.type,
    required this.email,
    required this.company_code,
    required this.movil,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_name': company_name,
      'name': name,
      'last_name': last_name,
      'ci': ci,
      'type': type,
      'email': email,
      'company_code': company_code,
      'movil': movil,
      'username': username,
      'password': password,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id']?.toInt() ?? 0,
      company_name: map['company_name'] ?? '',
      name: map['name'] ?? '',
      last_name: map['last_name'] ?? '',
      ci: map['ci'] ?? '',
      type: map['type'] ?? '',
      email: map['email'] ?? '',
      company_code: map['company_code'] ?? '',
      movil: map['movil'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source));
}
