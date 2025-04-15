import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/list.dart';
import 'package:tracker/models/structureclass.dart' as structure;
import 'package:tracker/new.dart';

// Date formatting for consistent date display
final formatter = DateFormat.yMd();

void main() {
  // This is the entry point of your Flutter app.
  runApp(const MyApp()); // Run the app with MyApp as the root widget.
}

// MyApp is the root widget of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        // Set up the basic Material Design structure.
        debugShowCheckedModeBanner: false, // Remove the debug banner.
        title: 'Expense Tracker', // Set the title of the app.
        theme: ThemeData(
          // Define the app's theme (colors, text styles, etc.).
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ), // Use a seed color to generate a color scheme.
          useMaterial3: true, // Enable Material 3 design.
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.deepPurple.shade50,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        home: const Expense(), // Set the Expense widget as the home screen.
      ),
    );
  }
}

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
      isScrollControlled: true, // Allow the modal to be scrollable
      builder:
          (ctx) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: New(onAddExpense: _addExpense), // Simplified builder
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(
          context,
        ).size.width; //used to calculate the width of the keyboard

    // Determine the main content to display based on whether there are expenses or not
    Widget mainContent = const Center(child: Text('No expenses added yet!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Thelist(
        expenses: _registeredExpenses,
        onDelete: _removeExpense,
      );
    }

    // Build the category icons row
    Widget categoryIconsRow = Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              structure.Category.values.map((category) {
                // Get the icon for the current category
                final icon = structure.categoryIcons[category];
                // Count the number of expenses in the current category
                final count =
                    _registeredExpenses
                        .where((expense) => expense.category == category)
                        .length;

                return Column(
                  children: [
                    Icon(icon, size: 36), // Display the category icon
                    Text(
                      '$count',
                    ), // Display the number of expenses in the category
                  ],
                );
              }).toList(),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent keyboard from overlapping input fields
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker App'),
        actions: [
          IconButton(
            onPressed: _openNewExpenseModal,
            icon: const Icon(Icons.add),
          ),
        ], // Call the correct function
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'The Chart',
                      style:
                          Theme.of(
                            context,
                          ).textTheme.headlineMedium, // Larger text size
                    ),
                  ), // Text indicating the chart area
                  SizedBox(
                    height: 100,
                    child: categoryIconsRow,
                  ), // Increased height for categoryIconsRow
                  Expanded(
                    child: mainContent,
                  ), // Main content (list of expenses or "no expenses" message)
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
                            style:
                                Theme.of(
                                  context,
                                ).textTheme.headlineMedium, // Larger text size
                          ),
                        ), // Text indicating the chart area
                        SizedBox(
                          height: 100,
                          child: categoryIconsRow,
                        ), // Increased height for categoryIconsRow
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        mainContent, // Main content (list of expenses or "no expenses" message)
                  ),
                ],
              ),
    );
  }
}
