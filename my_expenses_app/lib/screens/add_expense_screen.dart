import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expense_app/models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final void Function(Expense newExpense) onAddExpense;

const AddExpenseScreen({Key? key, required this.onAddExpense}) : super(key: key);


  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? selectedDate;
  List<Map<String, TextEditingController>> items = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    addNewItem(); // Start with one item
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
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1B2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Confirm Expense',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to add this expense?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _showSuccessPopup(); // Then show success
            },
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(backgroundColor: Color(0xFF2A293A)),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

 void _showSuccessPopup() {
  // Create the new expense object
  final newExpense = Expense(
    amount: double.tryParse(_totalController.text) ?? 0,
    date: selectedDate ?? DateTime.now(),
    items: items.map((item) => {
      'item': item['item']!.text,
      'amount': item['amount']!.text,
    }).toList(),
    note: _noteController.text, category: '',
  );

  // ✅ Call the callback
  widget.onAddExpense(newExpense);

  // Show dialog
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
          Text(
            'Expense successfully added',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );

  // Then dismiss after delay
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(); // close popup
    Navigator.of(context).pop(); // go back to HomeScreen
  });
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
                      DateFormat('dd/MM/yyyy').format(selectedDate!),
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
                onPressed: _showConfirmDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
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
}
