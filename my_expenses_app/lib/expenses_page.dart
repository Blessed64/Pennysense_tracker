import 'add_expense_screen.dart';
import 'package:flutter/material.dart';


class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseList = List.generate(6, (index) => {
      'date': '22/11/24',
      'category': 'Food & Drinks',
      'amount': '₦10,000',
    });

    return Scaffold(
      backgroundColor: const Color(0xFF12101C),
appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text('My Expenses', style: TextStyle(color: Colors.white)),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        child: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    ),
  ],
),
body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
            Row(
              children: [
                Expanded(child: _buildDropdownButton('NOV')),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdownButton('2024')),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2A64F6), Color(0xFF479BFD)],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('This Month', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('₦0.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  VerticalDivider(color: Colors.white24, thickness: 1),
                  Expanded(
                    child: Column(
                      children: [
                        Text('This Year', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('₦0.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Expense History', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: expenseList.length,
                itemBuilder: (context, index) {
                  final item = expenseList[index];
                  return Card(
                    color: const Color(0xFF1C1A2A),
                    child: ListTile(
                      title: Text(item['category']!, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(item['date']!, style: const TextStyle(color: Colors.white70)),
                      trailing: Text(item['amount']!, style: const TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: const Color(0xFF1C1A2A),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.white),
        isExpanded: true,
        items: [value].map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        }).toList(),
        onChanged: (newValue) {},
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: const Center(
        child: Text('Add Expense Screen'),
      ),
    );
  }
}
