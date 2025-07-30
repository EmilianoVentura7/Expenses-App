import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expenses_app/core/network/dio_client.dart';
import 'package:expenses_app/core/services/local_storage_service.dart';
import 'package:expenses_app/features/login/data/datasources/remote/login_service.dart';
import 'package:expenses_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:expenses_app/features/login/domain/usecases/login_use_case.dart';
// Registro
import 'package:expenses_app/features/register/data/datasources/remote/register_service.dart';
import 'package:expenses_app/features/register/data/repositories/register_repository_impl.dart';
import 'package:expenses_app/features/register/domain/usecases/register_use_case.dart';
// Home
import 'package:expenses_app/features/home/data/datasources/remote/home_service.dart';
import 'package:expenses_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:expenses_app/features/home/domain/usecases/home_use_case.dart';
import 'package:expenses_app/features/home/data/datasources/remote/logout_service.dart';
import 'package:expenses_app/features/home/data/repositories/logout_repository_impl.dart';
import 'package:expenses_app/features/home/domain/usecases/logout_use_case.dart';
// Gastos
import 'package:expenses_app/features/expenses/data/datasources/remote/expenses_service.dart';
import 'package:expenses_app/features/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:expenses_app/features/expenses/domain/usecases/get_expenses_use_case.dart';
// Agregar Gastos
import 'package:expenses_app/features/add_expenses/data/datasources/remote/add_expense_service.dart';
import 'package:expenses_app/features/add_expenses/data/repositories/add_expense_repository_impl.dart';
import 'package:expenses_app/features/add_expenses/domain/usecases/add_expense_use_case.dart';
// Actualizar Gastos
import 'package:expenses_app/features/update_expenses/data/datasources/remote/update_expense_service.dart';
import 'package:expenses_app/features/update_expenses/data/repositories/update_expense_repository_impl.dart';
import 'package:expenses_app/features/update_expenses/domain/usecases/get_expense_by_id_use_case.dart';
import 'package:expenses_app/features/update_expenses/domain/usecases/update_expense_use_case.dart';
import 'package:expenses_app/features/update_expenses/domain/usecases/delete_expense_use_case.dart';

class AppModule {
  static final Dio dio = Dio();
  static late final SharedPreferences _prefs;
  static late final LocalStorageService _storageService;
  static late final DioClient dioClient;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _storageService = LocalStorageService(_prefs);
    dioClient = DioClient(dio: dio, localStorageService: _storageService);
  }

  static LoginUseCase loginUseCase() {
    final loginService = LoginService(dioClient);
    final repository = LoginRepositoryImpl(loginService, _storageService);
    return LoginUseCase(repository);
  }

  static RegisterUseCase registerUseCase() {
    final registerService = RegisterService(dioClient);
    final repository = RegisterRepositoryImpl(registerService);
    return RegisterUseCase(repository);
  }

  static HomeUseCase homeUseCase() {
    final homeService = HomeService(dioClient);
    final repository = HomeRepositoryImpl(homeService);
    return HomeUseCase(repository);
  }

  static LogoutUseCase logoutUseCase() {
    final logoutService = LogoutService(dioClient);
    final repository = LogoutRepositoryImpl(logoutService, _storageService);
    return LogoutUseCase(repository);
  }

  static GetExpensesUseCase getExpensesUseCase() {
    final expensesService = ExpensesService(dioClient);
    final repository = ExpensesRepositoryImpl(expensesService);
    return GetExpensesUseCase(repository);
  }

  static AddExpenseUseCase addExpenseUseCase() {
    final addExpenseService = AddExpenseService(dioClient);
    final repository = AddExpenseRepositoryImpl(addExpenseService);
    return AddExpenseUseCase(repository);
  }

  static GetExpenseByIdUseCase getExpenseByIdUseCase() {
    final updateExpenseService = UpdateExpenseService(dioClient);
    final repository = UpdateExpenseRepositoryImpl(updateExpenseService);
    return GetExpenseByIdUseCase(repository);
  }

  static UpdateExpenseUseCase updateExpenseUseCase() {
    final updateExpenseService = UpdateExpenseService(dioClient);
    final repository = UpdateExpenseRepositoryImpl(updateExpenseService);
    return UpdateExpenseUseCase(repository);
  }

  static DeleteExpenseUseCase deleteExpenseUseCase() {
    final updateExpenseService = UpdateExpenseService(dioClient);
    final repository = UpdateExpenseRepositoryImpl(updateExpenseService);
    return DeleteExpenseUseCase(repository);
  }

  static LocalStorageService localStorageService() {
    return _storageService;
  }
}
