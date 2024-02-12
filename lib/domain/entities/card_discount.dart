class CardDiscount {
  int id;
  String card;
  String user;
  double amount;
  String date;
  String time;
  CardDiscount({
    required this.id,
    required this.card,
    required this.user,
    required this.amount,
    required this.date,
    required this.time,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CardDiscount &&
      other.id == id &&
      other.card == card &&
      other.user == user &&
      other.amount == amount &&
      other.date == date &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      card.hashCode ^
      user.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      time.hashCode;
  }
}
