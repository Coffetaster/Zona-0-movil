import 'package:zona0_apk/domain/entities/entities.dart';

class Company {
  int id;
  String company_name;
  String name;
  String last_name;
  String ci;

  /*
  Type: enum
  [Mipyme, TCP, Estatal]
  */
  String company_type;
  String email;
  String company_code;
  String movil;
  String username;
  String password;
  Company({
    required this.id,
    required this.company_name,
    required this.name,
    required this.last_name,
    required this.ci,
    required this.company_type,
    required this.email,
    required this.company_code,
    required this.movil,
    required this.username,
    required this.password,
  });

  factory Company.fromClient({
    required Client client,
    required companyName,
    required companyCode,
    required companyType,
  }) {
    return Company(
        id: client.id,
        company_name: companyName,
        name: client.name,
        last_name: client.last_name,
        ci: client.ci,
        company_type: companyType,
        email: client.email,
        company_code: companyCode,
        movil: client.movil,
        username: client.username,
        password: client.password);
  }

  Company copyWith({
    int? id,
    String? company_name,
    String? name,
    String? last_name,
    String? ci,
    String? type,
    String? email,
    String? company_code,
    String? movil,
    String? username,
    String? password,
  }) {
    return Company(
      id: id ?? this.id,
      company_name: company_name ?? this.company_name,
      name: name ?? this.name,
      last_name: last_name ?? this.last_name,
      ci: ci ?? this.ci,
      company_type: type ?? this.company_type,
      email: email ?? this.email,
      company_code: company_code ?? this.company_code,
      movil: movil ?? this.movil,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'Company(id: $id, company_name: $company_name, name: $name, last_name: $last_name, ci: $ci, type: $company_type, email: $email, company_code: $company_code, movil: $movil, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        (other.id == id ||
            other.ci == ci ||
            other.email == email ||
            other.username == username);
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
