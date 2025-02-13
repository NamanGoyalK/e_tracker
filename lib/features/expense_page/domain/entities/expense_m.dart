class Expense {
  final String name;
  final DateTime createdAt;
  final String price;

  Expense({
    required this.name,
    required this.createdAt,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'price': price,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      price: json['price'],
    );
  }
}
