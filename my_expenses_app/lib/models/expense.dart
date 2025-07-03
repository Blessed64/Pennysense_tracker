class Expense {
  final double amount;
  final DateTime date;
  final Map<String, double> details;
  final String? note;

  Expense({
    required this.amount,
    required this.date,
    required this.details,
    this.note,
  });
}
