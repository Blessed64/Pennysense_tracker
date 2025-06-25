import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap; // Allow tap navigation

  const ExpenseTile({
    Key? key,
    required this.expense,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Triggers navigation when tapped
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF2A293A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 🗓️ Date
            Text(
              DateFormat('dd MMM').format(expense.date),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            // 📌 Static Category or Icon (optional)
            const Icon(Icons.category_outlined, color: Colors.white38, size: 20),
            const SizedBox(width: 6),
            const Text(
              'Expense',
              style: TextStyle(color: Colors.white70),
            ),

            const Spacer(),

            // 💰 Amount
            Text(
              '₦${expense.amount.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
