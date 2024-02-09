import 'dart:convert';

class User {
  int id;
  String username;
  String name;
  String lastName;
  String image;
  double ospPoint;
  String movil;
  String ci;
  String userType;
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.image,
    required this.ospPoint,
    required this.movil,
    required this.ci,
    required this.userType,
  });

  bool get isClient {
    return userType.toLowerCase() == "client";
  }

  bool get isCompany {
    return userType.toLowerCase() == "company";
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

  User copyWith({
    int? id,
    String? username,
    String? name,
    String? lastName,
    String? image,
    double? ospPoint,
    String? movil,
    String? ci,
    String? userType,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      ospPoint: ospPoint ?? this.ospPoint,
      movil: movil ?? this.movil,
      ci: ci ?? this.ci,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'lastName': lastName,
      'image': image,
      'ospPoint': ospPoint,
      'movil': movil,
      'ci': ci,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      image: map['image'] ?? '',
      ospPoint: map['ospPoint']?.toDouble() ?? 0.0,
      movil: map['movil'] ?? '',
      ci: map['ci'] ?? '',
      userType: map['userType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, lastName: $lastName, image: $image, ospPoint: $ospPoint, movil: $movil, ci: $ci, userType: $userType)';
  }
}
