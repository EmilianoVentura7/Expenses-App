import '../repositories/update_expense_repository.dart';

class GetExpenseByIdUseCase {
  final UpdateExpenseRepository _updateExpenseRepository;

  GetExpenseByIdUseCase(this._updateExpenseRepository);

  Future<Map<String, dynamic>> call(int id) async {
    return await _updateExpenseRepository.getExpenseById(id);
  }
}
