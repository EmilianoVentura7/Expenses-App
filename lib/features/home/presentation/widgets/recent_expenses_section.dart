import 'package:flutter/material.dart';
import '../../domain/entities/home_entity.dart';
import 'expense_item.dart';

class RecentExpensesSection extends StatelessWidget {
  final List<ExpenseEntity> expenses;

  const RecentExpensesSection({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gastos e ingresos recientes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...expenses.map((expense) => ExpenseItem(expense: expense)),
      ],
    );
  }
}
