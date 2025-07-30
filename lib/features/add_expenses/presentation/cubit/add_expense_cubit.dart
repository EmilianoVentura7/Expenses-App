import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/add_expense_entity.dart';
import '../../domain/usecases/add_expense_use_case.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseUseCase _addExpenseUseCase;

  AddExpenseCubit(this._addExpenseUseCase) : super(AddExpenseInitial());

  Future<void> addExpense({
    required String description,
    required double amount,
    required String type,
    required int categoryId,
    required String date,
  }) async {
    emit(AddExpenseLoading());

    try {
      final expense = AddExpenseEntity(
        description: description,
        amount: amount,
        type: type,
        categoryId: categoryId,
        date: date,
      );

      final result = await _addExpenseUseCase(expense);
      emit(AddExpenseSuccess(result));
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }

  void resetState() {
    emit(AddExpenseInitial());
  }
}
