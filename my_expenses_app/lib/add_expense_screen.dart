
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _totalController = TextEditingController();
  final _itemController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? selectedDate;
  List<Map<String, dynamic>> items = [];

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      items.add({
        'item': _itemController.text,
        'amount': double.tryParse(_amountController.text) ?? 0.0,
      });
      _itemController.clear();
      _amountController.clear();
      setState(() {});
    }
  }

  void _confirmExpense() {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      final total = double.tryParse(_totalController.text) ?? 0.0;
      final note = _noteController.text;

      final expense = Expense(
        amount: total,
        date: selectedDate!,
        category: items.isNotEmpty ? items[0]['item'] : 'General',
        note: note.isEmpty ? null : note,
      );

      Navigator.pop(context, expense);
    }
  }

  @override
  void dispose() {
    _totalController.dispose();
    _itemController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _totalController,
                decoration: const InputDecoration(
                  labelText: 'How much spent in total(₦)',
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Enter total amount' : null,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: selectedDate == null
                          ? 'Date spent'
                          : DateFormat.yMMMd().format(selectedDate!),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (_) => selectedDate == null ? 'Pick a date' : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _itemController,
                      decoration: const InputDecoration(labelText: 'Item'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Amount(₦)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Expense'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C2B3E),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Additional Information',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Confirm Expense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Expense {
  final double amount;
  final DateTime date;
  final String category;
  final String? note;

  Expense({
    required this.amount,
    required this.date,
    required this.category,
    this.note,
  });

  @override
  String toString() {
    return 'Expense(amount: $amount, date: $date, category: $category, note: $note)';
  }
}
