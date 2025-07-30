import '../../domain/entities/update_expense_entity.dart';
import '../../domain/repositories/update_expense_repository.dart';
import '../datasources/remote/update_expense_service.dart';
import '../models/update_expense_model.dart';

class UpdateExpenseRepositoryImpl implements UpdateExpenseRepository {
  final UpdateExpenseService _updateExpenseService;

  UpdateExpenseRepositoryImpl(this._updateExpenseService);

  @override
  Future<Map<String, dynamic>> getExpenseById(int id) async {
    try {
      return await _updateExpenseService.getExpenseById(id);
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateExpense(
    UpdateExpenseEntity expense,
  ) async {
    try {
      final expenseModel = UpdateExpenseModel(
        id: expense.id,
        description: expense.description,
        amount: expense.amount,
        type: expense.type,
        categoryId: expense.categoryId,
        date: expense.date,
      );

      return await _updateExpenseService.updateExpense(expenseModel);
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    try {
      print('Repositorio: Iniciando eliminación del gasto $id');
      await _updateExpenseService.deleteExpense(id);
      print('Repositorio: Gasto eliminado exitosamente');
    } catch (e) {
      print('Repositorio: Error al eliminar gasto: $e');
      throw Exception('Error en el repositorio: $e');
    }
  }
}
