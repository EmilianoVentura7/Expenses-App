import '../repositories/update_expense_repository.dart';

class DeleteExpenseUseCase {
  final UpdateExpenseRepository _updateExpenseRepository;

  DeleteExpenseUseCase(this._updateExpenseRepository);

  Future<void> call(int id) async {
    print('UseCase: Iniciando eliminación del gasto $id');
    final result = await _updateExpenseRepository.deleteExpense(id);
    print('UseCase: Eliminación completada');
    return result;
  }
}
