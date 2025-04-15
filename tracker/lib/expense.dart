import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/list.dart';
import 'package:tracker/models/structureclass.dart' as structure;
import 'package:tracker/new.dart'; // Correct import: new.dart

// Date formatting for consistent date display
final formatter = DateFormat.yMd();

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  // Initial list of registered expenses (for demonstration purposes)
  final List<structure.Yvonne> _registeredExpenses = [
    structure.Yvonne(
      amount: 19.99,
      date: DateTime.now(),
      title: 'Flutter Course',
      category: structure.Category.work,
    ),
    structure.Yvonne(
      amount: 15.99,
      date: DateTime.now(),
      title: 'Cinema',
      category: structure.Category.leisure,
    ),
  ];

  // Function to add a new expense to the list
  void _addExpense(structure.Yvonne expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Function to remove an expense from the list
  void _removeExpense(structure.Yvonne expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  // Function to open the modal bottom sheet for adding a new expense
  void _openNewExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to expand beyond the keyboard
      builder: (BuildContext context) {
        return FractionallySizedBox( // Use FractionallySizedBox to control size
          heightFactor: 0.9, // Adjust this value as needed
          child: New(onAddExpense: _addExpense),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; //used to calculate the width of the keyboard

    // Determine the main content to display based on whether there are expenses or not
    Widget mainContent = const Center(child: Text('No expenses added yet!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Thelist(expenses: _registeredExpenses, onDelete: _removeExpense);
    }

    // Build the category icons row
    Widget categoryIconsRow = Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: structure.Category.values.map((category) {
            // Get the icon for the current category
            final icon = structure.categoryIcons[category];
            // Count the number of expenses in the current category
            final count = _registeredExpenses
                .where((expense) => expense.category == category)
                .length;

            return Column(
              children: [
                Icon(icon, size: 36), // Display the category icon
                Text('$count'), // Display the number of expenses in the category
              ],
            );
          }).toList(),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker App'),
        actions: [IconButton(onPressed: _openNewExpenseModal, icon: const Icon(Icons.add))], // Call the correct function
      ),
      body: width < 600
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'The Chart',
                    style: Theme.of(context).textTheme.headlineMedium, // Larger text size
                  ),
                ), // Text indicating the chart area
                SizedBox(height: 100, child: categoryIconsRow), // Increased height for categoryIconsRow
                Expanded(child: mainContent), // Main content (list of expenses or "no expenses" message)
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'The Chart',
                          style: Theme.of(context).textTheme.headlineMedium, // Larger text size
                        ),
                      ), // Text indicating the chart area
                      SizedBox(height: 100, child: categoryIconsRow), // Increased height for categoryIconsRow
                    ],
                  ),
                ),
                Expanded(
                  child: mainContent, // Main content (list of expenses or "no expenses" message)
                ),
              ],
            ),
    );
  }
}
