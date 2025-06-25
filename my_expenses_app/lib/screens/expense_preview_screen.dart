import 'package:flutter/material.dart';
import 'package:my_expense_app/models/expense.dart';

class ExpensePreviewScreen extends StatelessWidget {
  final String amountSpent;
  final String dateSpent;
  final List<Map<String, String>> expenseDetails;
  final String note;

  const ExpensePreviewScreen({
    Key? key,
    required this.amountSpent,
    required this.dateSpent,
    required this.expenseDetails,
    required this.note, required Expense expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Expense preview'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2A293A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelValue('Amount spent', amountSpent),
              const SizedBox(height: 20),
              _buildLabelValue('Date spent', dateSpent),
              const SizedBox(height: 20),
              const Text(
                'Expense Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              ...expenseDetails.map((e) => Text(
                    '${e['item']} - ₦${e['amount']}',
                    style: const TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 20),
              _buildLabelValue('Additional Information', note),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
