class Client {
  int id;
  String username;
  String password;
  String name;
  String last_name;
  String email;
  String movil;
  String ci;

  Client({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.last_name,
    required this.email,
    required this.movil,
    required this.ci,
  });

  @override
  String toString() {
    return 'Client(id: $id, username: $username, password: $password, name: $name, last_name: $last_name, email: $email, movil: $movil, ci: $ci)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Client &&
      other.id == id &&
      other.username == username &&
      other.password == password &&
      other.name == name &&
      other.last_name == last_name &&
      other.email == email &&
      other.movil == movil &&
      other.ci == ci;
  }


  @override
  int get hashCode {
    return id.hashCode;
  }

  Client copyWith({
    int? id,
    String? username,
    String? password,
    String? name,
    String? last_name,
    String? email,
    String? movil,
    String? ci,
  }) {
    return Client(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      movil: movil ?? this.movil,
      ci: ci ?? this.ci,
    );
  }

}
