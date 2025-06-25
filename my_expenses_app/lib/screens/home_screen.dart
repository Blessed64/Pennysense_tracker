// TODO Implement this library.// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:my_expense_app/screens/expense_preview_screen.dart';
import 'add_expense_screen.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMonth = DateFormat.MMM().format(DateTime.now()).toUpperCase();
  int selectedYear = DateTime.now().year;

  List<Expense> expenses = [];

  double get totalMonth => expenses
      .where((e) => e.date.month == DateTime.now().month && e.date.year == DateTime.now().year)
      .fold(0.0, (sum, e) => sum + e.amount);

  double get totalYear => expenses
      .where((e) => e.date.year == DateTime.now().year)
      .fold(0.0, (sum, e) => sum + e.amount);

  void addNewExpense(Expense expense) {
    setState(() => expenses.add(expense));
  }

  List<String> get months => List.generate(12, (i) => DateFormat.MMM().format(DateTime(0, i + 1)).toUpperCase());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
    IconButton(
      icon: const Icon(Icons.add_circle_outline),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddExpenseScreen(
              onAddExpense: (Expense newExpense) {
                addNewExpense(newExpense); // ✅ Update list
              },
            ),
          ),
        );
      },
    ),
  ],
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Month & Year Dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedMonth,
                  items: months
                      .map((m) => DropdownMenuItem(child: Text(m), value: m))
                      .toList(),
                  onChanged: (value) => setState(() => selectedMonth = value!),
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  items: List.generate(10, (i) {
                    int year = DateTime.now().year - i;
                    return DropdownMenuItem(child: Text(year.toString()), value: year);
                  }),
                  onChanged: (value) => setState(() => selectedYear = value!),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Total Monthly and Yearly Summary
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('This Month', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text('₦${totalMonth.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  Container(height: 40, width: 1, color: Colors.white24),
                  Column(
                    children: [
                      const Text('This Year', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text('₦${totalYear.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Expense History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 8),

            /// Expense List
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (_, index) {
                  final expense = expenses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExpensePreviewScreen(expense: expense, amountSpent: '', dateSpent: '', expenseDetails: [], note: '',),
                        ),
                      );
                    },
                    child: ExpenseTile(expense: expense),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
