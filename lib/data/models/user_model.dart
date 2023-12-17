import 'dart:convert';

class UserModel {
  int pk;
  String username;
  String name;
  String last_name;
  String image;
  UserModel({
    required this.pk,
    required this.username,
    required this.name,
    required this.last_name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'pk': pk,
      'username': username,
      'name': name,
      'last_name': last_name,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      last_name: map['last_name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
