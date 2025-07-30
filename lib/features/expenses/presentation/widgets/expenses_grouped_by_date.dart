import 'package:flutter/material.dart';
import '../../data/models/expense_model.dart';
import 'expense_item_with_edit.dart';

class ExpensesGroupedByDate extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel)? onEdit;
  const ExpensesGroupedByDate({super.key, required this.expenses, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final grouped = _groupExpensesByDate(expenses);
    final sortedDateKeys =
        grouped.keys.toList()
          ..sort((a, b) => b.compareTo(a)); // DateTime descendente
    return ListView(
      children:
          sortedDateKeys.map((dateKey) {
            final entry = grouped[dateKey]!;
            // Ordenar por fecha y hora descendente dentro de cada grupo
            final sortedExpenses = [...entry]
              ..sort((a, b) => b.date.compareTo(a.date));
            final label = _formatDateLabel(dateKey, context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 4.0,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...sortedExpenses.map(
                  (expense) => ExpenseItemWithEdit(
                    expense: expense,
                    onEdit: onEdit != null ? () => onEdit!(expense) : null,
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  /// Agrupa por fecha (DateTime sin hora)
  Map<DateTime, List<ExpenseModel>> _groupExpensesByDate(
    List<ExpenseModel> expenses,
  ) {
    final Map<DateTime, List<ExpenseModel>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    for (final expense in expenses) {
      final date = DateTime.tryParse(expense.date);
      DateTime key;
      if (date != null) {
        key = DateTime(date.year, date.month, date.day);
      } else {
        key = DateTime(1970, 1, 1); // Sin fecha
      }
      grouped.putIfAbsent(key, () => []).add(expense);
    }
    return grouped;
  }

  String _formatDateLabel(DateTime date, BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (date == today) return 'Hoy';
    if (date == yesterday) return 'Ayer';
    if (date.year == 1970) return 'Sin fecha';
    return _formatDateSpanish(date);
  }

  String _formatDateSpanish(DateTime date) {
    final months = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    return '${date.day} de ${months[date.month]} de ${date.year}';
  }
}
