import '../models/expense_model.dart';
import '../datasources/remote/expenses_service.dart';
import '../../domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesService service;
  ExpensesRepositoryImpl(this.service) {
    print('ExpensesRepositoryImpl: INSTANCIADO');
  }

  @override
  Future<List<ExpenseModel>> getExpenses({
    int page = 1,
    int limit = 20,
    String? startDate,
    String? endDate,
    int? categoryId,
    String? type,
  }) async {
    print('ExpensesRepositoryImpl: llamando service.getExpenses');
    final response = await service.getExpenses(
      page: page,
      limit: limit,
      startDate: startDate,
      endDate: endDate,
      categoryId: categoryId,
      type: type,
    );
    
    print('ExpensesRepositoryImpl: response.data: ${response.data}');
    print('ExpensesRepositoryImpl: response.data type: ${response.data.runtimeType}');
    
    final expensesData = response.data['expenses'];
    print('ExpensesRepositoryImpl: expensesData: $expensesData');
    print('ExpensesRepositoryImpl: expensesData type: ${expensesData.runtimeType}');
    
    final expensesList = (expensesData is List) ? expensesData : <dynamic>[];
    print('ExpensesRepositoryImpl: expensesList: $expensesList');
    print('ExpensesRepositoryImpl: expensesList type: ${expensesList.runtimeType}');
    
    if (expensesList.isNotEmpty) {
      print('ExpensesRepositoryImpl: First expense: ${expensesList.first}');
      print('ExpensesRepositoryImpl: First expense type: ${expensesList.first.runtimeType}');
    }
    
    return expensesList.map((e) => ExpenseModel.fromJson(e)).toList();
  }
}