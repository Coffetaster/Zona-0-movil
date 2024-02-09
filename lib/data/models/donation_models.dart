import 'dart:convert';

class DonationModel {
  int id;
  String user;
  double amount;
  String institution;
  DonationModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.institution,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'amount': amount,
      'institution': institution,
    };
  }

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      amount: map['amount']?.toDouble() ?? 0,
      institution: map['institution'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DonationModel.fromJson(String source) => DonationModel.fromMap(json.decode(source));
}
