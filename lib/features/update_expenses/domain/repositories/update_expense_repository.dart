import '../entities/update_expense_entity.dart';

abstract class UpdateExpenseRepository {
  Future<Map<String, dynamic>> getExpenseById(int id);
  Future<Map<String, dynamic>> updateExpense(UpdateExpenseEntity expense);
  Future<void> deleteExpense(int id);
}
