import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../screens/expense_preview_screen.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A293A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExpensePreviewScreen(expense: expense),
            ),
          );
        },
        title: Center(
          child: Text(
            DateFormat('dd MMM yyyy').format(expense.date),
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        subtitle: Column(
          children: expense.details.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: entry.key,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const TextSpan(text: '  '), // little space between name and amount
                      TextSpan(
                        text: '₦${entry.value.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        trailing: Text(
          '₦${expense.amount.toStringAsFixed(0)}',
          style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
