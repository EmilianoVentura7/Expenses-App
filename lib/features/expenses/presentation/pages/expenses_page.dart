import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/expenses_cubit.dart';
import '../cubit/expenses_state.dart';
import '../widgets/expenses_grouped_by_date.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  int _selectedIndex = 1; // Gastos

  @override
  void initState() {
    super.initState();
    context.read<ExpensesCubit>().loadExpenses();
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        // Ya estamos en gastos
        break;
      case 2:
        context.go('/budget'); // Ajusta la ruta si tienes otra
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos e ingresos', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              context.go('/add-expense');
            },
            tooltip: 'Añadir gasto',
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExpensesSuccess) {
            return ExpensesGroupedByDate(
              expenses: state.expenses,
              onEdit: (expense) {
                context.go('/update-expense/${expense.id}');
              },
            );
          }
          if (state is ExpensesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No hay gastos disponibles'));
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
