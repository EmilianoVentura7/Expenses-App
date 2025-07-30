import '../../data/models/expense_model.dart';

abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesSuccess extends ExpensesState {
  final List<ExpenseModel> expenses;
  ExpensesSuccess(this.expenses);
}

class ExpensesError extends ExpensesState {
  final String message;
  ExpensesError(this.message);
}
