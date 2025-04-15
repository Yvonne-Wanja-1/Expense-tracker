import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Formatter for date output
final formatter = DateFormat.yMd();

// Generate unique IDs
final Uuid uuid = Uuid();

// Enum for expense categories
enum Category { food, travel, leisure, work, other }

// Map to associate categories with icons
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.category, // Added an icon for 'other' category
};

// Class representing an individual expense
class Yvonne {
  Yvonne({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid.v4(); // Generate a unique ID when creating an expense

  final String id; // Unique ID for the expense
  final DateTime date; // Date of the expense
  final String title; // Title/description of the expense
  final double amount; // Amount of the expense
  final Category category; // Category of the expense

  // Getter to format the date as a string
  String get formattedDate {
    return formatter.format(date);
  }
}

// Class representing a bucket of expenses for a specific category
class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Yvonne> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category; // Category of the expenses in this bucket
  final List<Yvonne> expenses; // List of expenses in this bucket

  // Getter to calculate the total expenses in this bucket
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
