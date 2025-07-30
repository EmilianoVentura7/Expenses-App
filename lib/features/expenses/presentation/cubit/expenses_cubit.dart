import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_expenses_use_case.dart';
import 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUseCase getExpensesUseCase;
  ExpensesCubit(this.getExpensesUseCase) : super(ExpensesInitial());

  Future<void> loadExpenses({
    int page = 1,
    int limit = 20,
    String? startDate,
    String? endDate,
    int? categoryId,
    String? type,
  }) async {
    emit(ExpensesLoading());
    try {
      print('ExpensesCubit: llamando getExpensesUseCase');
      final expenses = await getExpensesUseCase(
        page: page,
        limit: limit,
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
        type: type,
      );
      print('ExpensesCubit: expenses recibidas: ${expenses.length}');
      emit(ExpensesSuccess(expenses));
    } catch (e) {
      print('ExpensesCubit: error: $e');
      emit(ExpensesError(e.toString()));
    }
  }
}