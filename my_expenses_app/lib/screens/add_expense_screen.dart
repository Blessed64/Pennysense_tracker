import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final Function(Expense) onAddExpense;

  const AddExpenseScreen({super.key, required this.onAddExpense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _totalController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<Map<String, TextEditingController>> items = [];

  @override
  void initState() {
    super.initState();
    addNewItem();
  }

  void addNewItem() {
    setState(() {
      items.add({
        'item': TextEditingController(),
        'amount': TextEditingController(),
      });
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

void _confirmExpense() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Confirm Expense',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Are you sure you want to add this expense?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Row with two buttons side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Confirm Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _submitExpense();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Confirm'),
                ),
              ),

              const SizedBox(width: 16), // spacing between buttons

              // Cancel Button
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}




  void _submitExpense() {
    double total = double.tryParse(_totalController.text) ?? 0.0;
    Map<String, double> detailMap = {};
    for (var item in items) {
      String name = item['item']?.text ?? '';
      double amount = double.tryParse(item['amount']?.text ?? '') ?? 0.0;
      if (name.isNotEmpty && amount > 0) {
        detailMap[name] = amount;
      }
    }

    final newExpense = Expense(
      amount: total,
      date: selectedDate,
      details: detailMap,
      note: _noteController.text,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1B2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.verified, color: Colors.greenAccent),
            SizedBox(width: 12),
            Text('Expense successfully added', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // close success
      Navigator.of(context).pop(newExpense); // pass expense to HomeScreen
    });
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Expense'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _totalController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('₦10,000'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: _boxDecoration(),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: item['item'],
                      decoration: _inputDecoration('Item'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: item['amount'],
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('₦5000'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: addNewItem,
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A293A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: _inputDecoration('Additional Information'),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _confirmExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Confirm Expense'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
