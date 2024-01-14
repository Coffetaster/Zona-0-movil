import 'dart:convert';

class TransactionModel {
  int id;
  String user;
  double amount;
  String code;
  /*
    - Unpaid
    - Paid
  */
  String state;
  String image;
  String date;
  String time;
  TransactionModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.code,
    required this.state,
    required this.image,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'amount': amount,
      'code': code,
      'state': state,
      'image': image,
      'date': date,
      'time': time,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      code: map['code'] ?? '',
      state: map['state'] ?? '',
      image: map['image'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source));
}
