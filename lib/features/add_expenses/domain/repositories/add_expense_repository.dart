import '../entities/add_expense_entity.dart';

abstract class AddExpenseRepository {
  Future<Map<String, dynamic>> addExpense(AddExpenseEntity expense);
}
