import 'dart:convert';

class DepositModel {
  int id;
  String user;
  String state;
  double amount;
  String date;
  String time;
  double interest;
  int date_banked;
  double post_interest;
  DepositModel({
    required this.id,
    required this.user,
    required this.state,
    required this.amount,
    required this.date,
    required this.time,
    required this.interest,
    required this.date_banked,
    required this.post_interest,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'state': state,
      'amount': amount,
      'date': date,
      'time': time,
      'interest': interest,
      'date_banked': date_banked,
      'post_interest': post_interest,
    };
  }

  factory DepositModel.fromMap(Map<String, dynamic> map) {
    return DepositModel(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      state: map['state'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      interest: map['interest']?.toDouble() ?? 0.0,
      date_banked: map['date_banked']?.toInt() ?? 0,
      post_interest: map['post_interest']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepositModel.fromJson(String source) => DepositModel.fromMap(json.decode(source));
}
