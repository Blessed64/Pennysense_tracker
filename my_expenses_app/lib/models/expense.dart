// TODO Implement this library.// models/expense.dart
class Expense {
  final DateTime date;
  final String category;
  final double amount;
  final String? note;

  Expense({
    required this.date,
    required this.category,
    required this.amount,
    this.note, required List<Map<String, String>> items,
  });
}
