class Deposit {
  int id;
  String user;
  String state;
  double amount;
  String date;
  String time;
  double interest;
  int date_banked;
  double post_interest;
  Deposit({
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

  bool get canRetired => state.toLowerCase() != "banked";

  @override
  String toString() {
    return 'Deposit(id: $id, user: $user, state: $state, amount: $amount, date: $date, time: $time, interest: $interest, date_banked: $date_banked, post_interest: $post_interest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Deposit &&
      other.id == id &&
      other.user == user &&
      other.state == state &&
      other.amount == amount &&
      other.date == date &&
      other.time == time &&
      other.interest == interest &&
      other.date_banked == date_banked &&
      other.post_interest == post_interest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      state.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      time.hashCode ^
      interest.hashCode ^
      date_banked.hashCode ^
      post_interest.hashCode;
  }
}
