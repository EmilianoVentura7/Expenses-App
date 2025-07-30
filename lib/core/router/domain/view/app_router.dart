import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenses_app/core/router/domain/constants/router_constants.dart';
import 'package:expenses_app/core/di/app_module.dart';
import 'package:expenses_app/features/login/presentation/pages/login_page.dart';
import 'package:expenses_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:expenses_app/features/register/presentation/pages/register_page.dart';
import 'package:expenses_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:expenses_app/features/home/presentation/pages/home_page.dart';
import 'package:expenses_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:expenses_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:expenses_app/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:expenses_app/features/add_expenses/presentation/pages/add_expense_page.dart';
import 'package:expenses_app/features/add_expenses/presentation/cubit/add_expense_cubit.dart';
import 'package:expenses_app/features/update_expenses/presentation/pages/update_expense_page.dart';
import 'package:expenses_app/features/update_expenses/presentation/cubit/update_expense_cubit.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouterConstants.login,
    routes: [
      GoRoute(
        path: RouterConstants.login,
        builder:
            (context, state) => BlocProvider(
              create:
                  (_) => LoginCubit(
                    loginUseCase: AppModule.loginUseCase(),
                    localStorageService: AppModule.localStorageService(),
                  ),
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: RouterConstants.register,
        builder:
            (context, state) => BlocProvider(
              create: (_) => RegisterCubit(AppModule.registerUseCase()),
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: RouterConstants.home,
        builder:
            (context, state) => BlocProvider(
              create: (_) => HomeCubit(AppModule.homeUseCase()),
              child: const HomePage(),
            ),
      ),
      GoRoute(
        path: RouterConstants.expenses,
        builder:
            (context, state) => BlocProvider(
              create: (_) => ExpensesCubit(AppModule.getExpensesUseCase()),
              child: const ExpensesPage(),
            ),
      ),
      GoRoute(
        path: RouterConstants.addExpenses,
        builder:
            (context, state) => BlocProvider(
              create: (_) => AddExpenseCubit(AppModule.addExpenseUseCase()),
              child: const AddExpensePage(),
            ),
      ),
      GoRoute(
        path: '/update-expense/:id',
        builder: (context, state) {
          final expenseId = int.parse(state.pathParameters['id'] ?? '0');
          return BlocProvider(
            create:
                (_) => UpdateExpenseCubit(
                  getExpenseByIdUseCase: AppModule.getExpenseByIdUseCase(),
                  updateExpenseUseCase: AppModule.updateExpenseUseCase(),
                  deleteExpenseUseCase: AppModule.deleteExpenseUseCase(),
                ),
            child: UpdateExpensePage(expenseId: expenseId),
          );
        },
      ),
    ],
  );
}
