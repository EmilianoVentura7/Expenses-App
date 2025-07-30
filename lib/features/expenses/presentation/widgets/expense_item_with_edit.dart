import 'package:flutter/material.dart';
import '../../data/models/expense_model.dart';

class ExpenseItemWithEdit extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback? onEdit;
  const ExpenseItemWithEdit({super.key, required this.expense, this.onEdit});

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'comida':
        return Icons.restaurant;
      case 'transporte':
        return Icons.directions_bus;
      case 'entretenimiento':
        return Icons.movie;
      case 'salud':
        return Icons.local_hospital;
      case 'educación':
      case 'educacion':
        return Icons.school;
      case 'otros':
        return Icons.category;
      default:
        return Icons.receipt;
    }
  }

  int _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return int.parse(hex, radix: 16);
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = expense.type == 'income';
    final amountText =
        isIncome
            ? '+\$${expense.amount.toStringAsFixed(2)}'
            : '-\$${expense.amount.toStringAsFixed(2)}';
    final amountColor = isIncome ? Colors.green : Colors.red;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Icono con fondo redondeado y color de la categoría
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(_hexToColor(expense.category.color)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForCategory(expense.category.name),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Información del gasto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        expense.description.isNotEmpty
                            ? expense.description
                            : 'Sin descripción',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      amountText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  expense.category.name,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Icono de editar
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            color: Colors.grey[700],
            tooltip: 'Editar gasto',
          ),
        ],
      ),
    );
  }
}
