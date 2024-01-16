class TransactionReceived {
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

  TransactionReceived({
    required this.id,
    required this.user,
    required this.amount,
    required this.code,
    required this.state,
    required this.image,
    required this.date,
    required this.time,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, user: $user, amount: $amount, code: $code, state: $state, image: $image, date: $date, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionReceived &&
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
