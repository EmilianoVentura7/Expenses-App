import '../repositories/expenses_repository.dart';
import '../../data/models/expense_model.dart';

class GetExpensesUseCase {
  final ExpensesRepository repository;
  GetExpensesUseCase(this.repository);

  Future<List<ExpenseModel>> call({
    int page = 1,
    int limit = 20,
    String? startDate,
    String? endDate,
    int? categoryId,
    String? type,
  }) async {
    print('GetExpensesUseCase: llamando repository.getExpenses');
    try {
      final result = await repository.getExpenses(
        page: page,
        limit: limit,
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
        type: type,
      );
      print('GetExpensesUseCase: resultado recibido: ${result.length}');
      return result;
    } catch (e) {
      print('GetExpensesUseCase: error: $e');
      rethrow;
    }
  }
}