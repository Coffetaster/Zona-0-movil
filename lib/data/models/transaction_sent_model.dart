import 'dart:convert';

class TransactionSentModel {
  int id;
  String user;
  double amount;
  String receiveUser;
  String date;
  String time;
  TransactionSentModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.receiveUser,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'receive amount': amount,
      'receive user': receiveUser,
      'date': date,
      'time': time,
    };
  }

  factory TransactionSentModel.fromMap(Map<String, dynamic> map) {
    return TransactionSentModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      amount: map['receive amount']?.toDouble() ?? 0.0,
      receiveUser: map['receive user'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionSentModel.fromJson(String source) => TransactionSentModel.fromMap(json.decode(source));
}
