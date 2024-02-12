import 'dart:convert';

class CardModel {
  int id;
  String user;
  double min_withdraw;
  bool active;
  String discount_code;
  CardModel({
    required this.id,
    required this.user,
    required this.min_withdraw,
    required this.active,
    required this.discount_code,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'min_withdraw': min_withdraw,
      'active': active,
      'discount_code': discount_code,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      min_withdraw: map['min_withdraw']?.toDouble() ?? 0.0,
      active: map['active'] ?? false,
      discount_code: map['discount_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source));
}
