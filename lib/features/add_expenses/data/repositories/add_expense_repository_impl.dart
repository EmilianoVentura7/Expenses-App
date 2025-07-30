import '../../domain/entities/add_expense_entity.dart';
import '../../domain/repositories/add_expense_repository.dart';
import '../datasources/remote/add_expense_service.dart';
import '../models/add_expense_model.dart';

class AddExpenseRepositoryImpl implements AddExpenseRepository {
  final AddExpenseService _addExpenseService;

  AddExpenseRepositoryImpl(this._addExpenseService);

  @override
  Future<Map<String, dynamic>> addExpense(AddExpenseEntity expense) async {
    try {
      final expenseModel = AddExpenseModel(
        description: expense.description,
        amount: expense.amount,
        type: expense.type,
        categoryId: expense.categoryId,
        date: expense.date,
      );
      
      return await _addExpenseService.addExpense(expenseModel);
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
} 