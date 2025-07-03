import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'expense_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];
  String selectedMonth = DateFormat.MMM().format(DateTime.now()).toUpperCase();
  int selectedYear = DateTime.now().year;

  double get totalMonth => expenses
      .where((e) => e.date.month == DateTime.now().month && e.date.year == DateTime.now().year)
      .fold(0.0, (sum, e) => sum + e.amount);

  double get totalYear => expenses
      .where((e) => e.date.year == DateTime.now().year)
      .fold(0.0, (sum, e) => sum + e.amount);

  List<String> get months => List.generate(12, (i) => DateFormat.MMM().format(DateTime(0, i + 1)).toUpperCase());

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('My Expenses'),
        foregroundColor: Colors.white,
actions: [
  Padding(
    padding: const EdgeInsets.only(right: 12),
    child: GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddExpenseScreen(onAddExpense: (Expense newExpense) {}),
          ),
        );
        if (result is Expense) {
          addExpense(result);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue, // 👈 blue background
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.add,
          color: Colors.white, // 👈 white icon on blue background
        ),
      ),
    ),
  ),
],
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Dropdowns for Month and Year
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // approximate top/left
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Month Dropdown
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 43,
        child: DropdownButton<String>(
          value: selectedMonth,
          underline: const SizedBox(),
          items: months
              .map((m) => DropdownMenuItem(
                    value: m,
                    child: Text(m),
                  ))
              .toList(),
          onChanged: (value) => setState(() => selectedMonth = value!),
        ),
      ),

      const SizedBox(width: 64), // 👈 spacing between month and year

      // Year Dropdown
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 43,
        child: DropdownButton<int>(
          value: selectedYear,
          underline: const SizedBox(),
          items: List.generate(10, (i) {
            int year = DateTime.now().year - i;
            return DropdownMenuItem(
              value: year,
              child: Text(year.toString()),
            );
          }),
          onChanged: (value) => setState(() => selectedYear = value!),
        ),
      ),
    ],
  ),
),

            const SizedBox(height: 20),

            /// Total summaries
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('This Month', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(
                        '₦${totalMonth.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Container(height: 40, width: 1, color: Colors.white24),
                  Column(
                    children: [
                      const Text('This Year', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(
                        '₦${totalYear.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Expense History',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: expenses.isEmpty
                  ? const Center(
                      child: Text('No expenses yet', style: TextStyle(color: Colors.white60)),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (_, index) {
                        final expense = expenses[index];
                        return ListTile(
                          tileColor: const Color(0xFF2A293A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Text(
                            DateFormat('dd/MM/yy').format(expense.date),
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            expense.details.keys.join(' & '),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Text(
                            '₦${expense.amount.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExpensePreviewScreen(expense: expense),
                              ),
                            );
                          },
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
