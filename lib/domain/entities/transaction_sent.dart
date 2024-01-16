class TransactionSent {
  int id;
  String user;
  double amount;
  String receiveUser;
  String date;
  String time;

  TransactionSent({
    required this.id,
    required this.user,
    required this.amount,
    required this.receiveUser,
    required this.date,
    required this.time,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionSent &&
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
