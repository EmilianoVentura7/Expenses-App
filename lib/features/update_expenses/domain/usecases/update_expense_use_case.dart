import '../entities/update_expense_entity.dart';
import '../repositories/update_expense_repository.dart';

class UpdateExpenseUseCase {
  final UpdateExpenseRepository _updateExpenseRepository;

  UpdateExpenseUseCase(this._updateExpenseRepository);

  Future<Map<String, dynamic>> call(UpdateExpenseEntity expense) async {
    return await _updateExpenseRepository.updateExpense(expense);
  }
} 