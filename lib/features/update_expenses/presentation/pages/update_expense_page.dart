import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/update_expense_cubit.dart';
import '../cubit/update_expense_state.dart';
import '../widgets/update_expense_form.dart';

class UpdateExpensePage extends StatefulWidget {
  final int expenseId;

  const UpdateExpensePage({super.key, required this.expenseId});

  @override
  State<UpdateExpensePage> createState() => _UpdateExpensePageState();
}

class _UpdateExpensePageState extends State<UpdateExpensePage> {
  @override
  void initState() {
    super.initState();
    // Cargar los datos del gasto al inicializar
    context.read<UpdateExpenseCubit>().getExpenseById(widget.expenseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Gasto o Ingreso'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/expenses'),
        ),
      ),
      body: BlocListener<UpdateExpenseCubit, UpdateExpenseState>(
        listener: (context, state) {
          if (state is UpdateExpenseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gasto actualizado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/expenses');
          } else if (state is DeleteExpenseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gasto eliminado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/expenses');
          } else if (state is UpdateExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UpdateExpenseCubit, UpdateExpenseState>(
          builder: (context, state) {
            if (state is GetExpenseByIdLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetExpenseByIdSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: UpdateExpenseForm(
                  expenseId: widget.expenseId,
                  initialExpense: state.expense,
                  cubit: context.read<UpdateExpenseCubit>(),
                ),
              );
            }

            if (state is UpdateExpenseError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/expenses'),
                      child: const Text('Volver a Gastos'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Cargando...'));
          },
        ),
      ),
    );
  }
}
