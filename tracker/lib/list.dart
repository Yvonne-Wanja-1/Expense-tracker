import 'package:flutter/material.dart';
import 'package:tracker/item.dart';
import 'package:tracker/models/structureclass.dart';

class Thelist extends StatelessWidget {
  const Thelist({super.key, required this.expenses, required this.onDelete});

  final List<Yvonne> expenses;
  final void Function(Yvonne) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, // is the number of lists, if the lists are two then the item builder will be called twice
      itemBuilder: (ctx, index) => Dismissible(
        direction: DismissDirection.endToStart, // dismissable to delete the list by swiping
        background: Container(
          color: Theme.of(context).colorScheme.error, // Color of the background when swiping to delete
          child: const Icon(Icons.delete, color: Colors.white, size: 40), // Delete icon
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            vertical: Theme.of(context).cardTheme.margin!.vertical,
          ),
        ),
        onDismissed: (direction) {
          onDelete(expenses[index]); // Call the onDelete function when dismissed
        },
        key: ValueKey(expenses[index]), // Unique key for each item
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Expense ${index + 1}', // Title for each expense
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            Eitem(expense: expenses[index]), // Display the expense item
          ],
        ),
      ),
    ); // using a column here is not ideal coz we don't know the number of lists that the user will input. thus listview which is automatically scrollable and has children
    // children: [], but we are using builder instead of children coz the lists will not be available unless buit by the user
  }
}
