import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/add_expense_cubit.dart';
import '../cubit/add_expense_state.dart';
import '../widgets/add_expense_form.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto o Ingreso'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/expenses'),
        ),
      ),
      body: BlocListener<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gasto agregado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/expenses');
          } else if (state is AddExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: AddExpenseForm(),
        ),
      ),
    );
  }
}
