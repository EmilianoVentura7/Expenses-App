import 'package:equatable/equatable.dart';

abstract class UpdateExpenseState extends Equatable {
  const UpdateExpenseState();

  @override
  List<Object?> get props => [];
}

class UpdateExpenseInitial extends UpdateExpenseState {}

class UpdateExpenseLoading extends UpdateExpenseState {}

class DeleteExpenseLoading extends UpdateExpenseState {}

class GetExpenseByIdLoading extends UpdateExpenseState {}

class GetExpenseByIdSuccess extends UpdateExpenseState {
  final Map<String, dynamic> expense;

  const GetExpenseByIdSuccess(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpenseSuccess extends UpdateExpenseState {
  final Map<String, dynamic> result;

  const UpdateExpenseSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class DeleteExpenseSuccess extends UpdateExpenseState {}

class UpdateExpenseError extends UpdateExpenseState {
  final String message;

  const UpdateExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
