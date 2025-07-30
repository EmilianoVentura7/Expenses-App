import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/update_expense_entity.dart';
import '../../domain/usecases/get_expense_by_id_use_case.dart';
import '../../domain/usecases/update_expense_use_case.dart';
import '../../domain/usecases/delete_expense_use_case.dart';
import 'update_expense_state.dart';

class UpdateExpenseCubit extends Cubit<UpdateExpenseState> {
  final GetExpenseByIdUseCase _getExpenseByIdUseCase;
  final UpdateExpenseUseCase _updateExpenseUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;

  UpdateExpenseCubit({
    required GetExpenseByIdUseCase getExpenseByIdUseCase,
    required UpdateExpenseUseCase updateExpenseUseCase,
    required DeleteExpenseUseCase deleteExpenseUseCase,
  }) : _getExpenseByIdUseCase = getExpenseByIdUseCase,
       _updateExpenseUseCase = updateExpenseUseCase,
       _deleteExpenseUseCase = deleteExpenseUseCase,
       super(UpdateExpenseInitial());

  Future<void> getExpenseById(int id) async {
    emit(GetExpenseByIdLoading());

    try {
      final expense = await _getExpenseByIdUseCase(id);
      emit(GetExpenseByIdSuccess(expense));
    } catch (e) {
      emit(UpdateExpenseError(e.toString()));
    }
  }

  Future<void> updateExpense({
    required int id,
    required String description,
    required double amount,
    required String type,
    required int categoryId,
    required String date,
  }) async {
    emit(UpdateExpenseLoading());

    try {
      final expense = UpdateExpenseEntity(
        id: id,
        description: description,
        amount: amount,
        type: type,
        categoryId: categoryId,
        date: date,
      );

      final result = await _updateExpenseUseCase(expense);
      emit(UpdateExpenseSuccess(result));
    } catch (e) {
      emit(UpdateExpenseError(e.toString()));
    }
  }

  Future<void> deleteExpense(int id) async {
    print('Cubit: Iniciando eliminación del gasto $id');
    emit(DeleteExpenseLoading());

    try {
      await _deleteExpenseUseCase(id);
      print('Cubit: Gasto eliminado exitosamente');
      emit(DeleteExpenseSuccess());
    } catch (e) {
      print('Cubit: Error al eliminar gasto: $e');
      emit(UpdateExpenseError(e.toString()));
    }
  }

  void resetState() {
    emit(UpdateExpenseInitial());
  }
}
