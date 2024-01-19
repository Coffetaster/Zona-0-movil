import 'dart:convert';

class UserModel {
  int pk;
  String username;
  String name;
  String last_name;
  String image;
  double zona_point;
  String movil;
  String ci;
  String user_type;
  UserModel({
    required this.pk,
    required this.username,
    required this.name,
    required this.last_name,
    required this.image,
    required this.zona_point,
    required this.movil,
    required this.ci,
    required this.user_type,
  });

  Map<String, dynamic> toMap() {
    return {
      'pk': pk,
      'username': username,
      'name': name,
      'last_name': last_name,
      'image': image,
      'zona_point': zona_point,
      'movil': movil,
      'ci': ci,
      'user_type': user_type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      last_name: map['last_name'] ?? '',
      image: map['image'] ?? '',
      zona_point: double.tryParse(map['zona_point'] ?? "0") ?? 0,
      movil: map['movil'] ?? '',
      ci: map['ci'] ?? '',
      user_type: map['user_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
