import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/models/structureclass.dart';

// Format for displaying dates (e.g., 12/25/2023)
final DateFormat formatter = DateFormat.yMd();

// Constants for padding and spacing to improve consistency and maintainability
const double kDefaultPadding = 16.0;
const double kSmallPadding = 8.0;
const double kLargePadding = 24.0;

class New extends StatefulWidget {
  const New({super.key, required this.onAddExpense});

  // Callback function to add a new expense
  final void Function(Yvonne expense) onAddExpense;

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  // Controllers for the text fields to manage their state
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  // Default selected category, initialized to 'other'
  Category _selectedCategory = Category.other;
  // Initially no date is selected, represented as null
  DateTime? _selectedDate;

  // Function to show the date picker
  Future<void> presentdate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    // Update the selected date and rebuild the UI
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // This function will validate the form and show an alert dialog if the input is invalid.
  void submitForm() {
    // Try to parse the entered amount as a double, or null if it fails
    final enteredAmount = double.tryParse(amountController.text);
    // Check if the amount is invalid (null or less than or equal to 0)
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    // Check if any of the required fields are invalid
    if (titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      // Show an alert dialog to inform the user about the invalid input
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure that a valid title, date, and category is selected."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); //to close the overlay automatically
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    // Create a new expense object and pass it to the callback function
    widget.onAddExpense(Yvonne(
      amount: enteredAmount!,
      date: _selectedDate!,
      title: titleController.text,
      category: _selectedCategory,
    ));

    Navigator.pop(context); // Close the modal after adding
  }

  @override
  void dispose() {
    // Removes the controller when exited to prevent memory leaks
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Removed unnecessary Scaffold and SizedBox
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          // Title and Amount TextFields
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: kDefaultPadding),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount', prefixText: '\$'),
          ),
          SizedBox(height: kDefaultPadding),
          // Date Picker
          InkWell(
            onTap: presentdate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_selectedDate == null ? 'No date Selected' : formatter.format(_selectedDate!)),
                SizedBox(width: kSmallPadding),
                const Icon(Icons.calendar_month),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding),
          // Category Dropdown
          DropdownButtonFormField<Category>(
            value: _selectedCategory,
            decoration: const InputDecoration(labelText: 'Category'),
            items: Category.values.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedCategory = value);
            },
          ),
          SizedBox(height: kLargePadding),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              SizedBox(width: kDefaultPadding),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

