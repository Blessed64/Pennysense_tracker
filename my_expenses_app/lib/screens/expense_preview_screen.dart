import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpensePreviewScreen extends StatelessWidget {
  final Expense expense;

  const ExpensePreviewScreen({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Expense preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A293A),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLabel("Amount spent"),
              Text(
                '₦${expense.amount.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),

              _buildLabel("Date spent"),
              Text(
                DateFormat('dd/MM/yyyy').format(expense.date),
                style: const TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),

             _buildLabel("Expense Details"),
const SizedBox(height: 8),

if (expense.details != null && expense.details!.isNotEmpty)
  ...expense.details!.entries.map(
    (entry) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 140, // fixed width to align all names
            child: Text(
              entry.key,
              style: const TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12), // spacing between name and amount
          Text(
            '₦${entry.value.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.lightGreen,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  )
else
  const Center(
    child: Text('-', style: TextStyle(color: Colors.grey)),
  ),



              _buildLabel("Additional Information"),
              Text(
                expense.note ?? '-',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
