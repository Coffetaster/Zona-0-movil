import 'dart:convert';

class BankingModel {
  int id;
  String user;
  String state;
  double amount;
  String date;
  String time;
  BankingModel({
    required this.id,
    required this.user,
    required this.state,
    required this.amount,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'state': state,
      'amount': amount,
      'date': date,
      'time': time,
    };
  }

  factory BankingModel.fromMap(Map<String, dynamic> map) {
    return BankingModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      state: map['state'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankingModel.fromJson(String source) => BankingModel.fromMap(json.decode(source));
}
