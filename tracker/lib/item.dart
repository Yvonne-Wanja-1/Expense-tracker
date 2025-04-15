import 'package:flutter/material.dart';
import 'package:tracker/models/structureclass.dart';

class Eitem extends StatelessWidget {
  const Eitem({super.key, required this.expense});

  final Yvonne expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer, // Card background color
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer, // Title color
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer, // Amount color
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        categoryIcons[expense.category],
                        color: Theme.of(context).colorScheme.onSecondaryContainer, // Icon color
                      ),
                      const SizedBox(width: 8),
                      Text(
                        expense.formattedDate,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer, // Date color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
