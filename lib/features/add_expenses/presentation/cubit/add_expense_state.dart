import 'package:equatable/equatable.dart';

abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}

class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {
  final Map<String, dynamic> result;

  const AddExpenseSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class AddExpenseError extends AddExpenseState {
  final String message;

  const AddExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
