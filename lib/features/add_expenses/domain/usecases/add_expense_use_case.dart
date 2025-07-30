import '../entities/add_expense_entity.dart';
import '../repositories/add_expense_repository.dart';

class AddExpenseUseCase {
  final AddExpenseRepository _addExpenseRepository;

  AddExpenseUseCase(this._addExpenseRepository);

  Future<Map<String, dynamic>> call(AddExpenseEntity expense) async {
    return await _addExpenseRepository.addExpense(expense);
  }
}
