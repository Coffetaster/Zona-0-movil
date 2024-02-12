class Card {
  int id;
  String user;
  double min_withdraw;
  bool active;
  String discount_code;
  Card({
    required this.id,
    required this.user,
    required this.min_withdraw,
    required this.active,
    required this.discount_code,
  });

  Card copyWith({
    int? id,
    String? user,
    double? min_withdraw,
    bool? active,
    String? discount_code,
  }) {
    return Card(
      id: id ?? this.id,
      user: user ?? this.user,
      min_withdraw: min_withdraw ?? this.min_withdraw,
      active: active ?? this.active,
      discount_code: discount_code ?? this.discount_code,
    );
  }
}
