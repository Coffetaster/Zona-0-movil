import 'dart:convert';

class CardDiscountModel {
  int id;
  String card;
  String user;
  double amount;
  String date;
  String time;
  CardDiscountModel({
    required this.id,
    required this.card,
    required this.user,
    required this.amount,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card': card,
      'user': user,
      'amount': amount,
      'date': date,
      'time': time,
    };
  }

  factory CardDiscountModel.fromMap(Map<String, dynamic> map) {
    return CardDiscountModel(
      id: map['id']?.toInt() ?? 0,
      card: map['card'] ?? '',
      user: map['user'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CardDiscountModel.fromJson(String source) => CardDiscountModel.fromMap(json.decode(source));
}
