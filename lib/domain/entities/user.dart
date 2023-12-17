import 'dart:convert';

class User {
  int id;
  String username;
  String name;
  String last_name;
  String image;
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.last_name,
    required this.image,
  });

  User copyWith({
    int? id,
    String? username,
    String? name,
    String? last_name,
    String? image,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      last_name: last_name ?? this.last_name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'last_name': last_name,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      last_name: map['last_name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, last_name: $last_name, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
