import '../../data/models/expense_model.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseModel>> getExpenses({
    int page,
    int limit,
    String? startDate,
    String? endDate,
    int? categoryId,
    String? type,
  });
}
