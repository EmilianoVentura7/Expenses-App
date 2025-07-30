import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_app/core/services/local_storage_service.dart';
import '../../domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final LocalStorageService _localStorageService;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required LocalStorageService localStorageService,
  }) : _loginUseCase = loginUseCase,
       _localStorageService = localStorageService,
       super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final token = await _loginUseCase(email, password);
      await _localStorageService.saveToken(token);
      emit(LoginSuccess(token));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _localStorageService.saveToken(''); // Limpiar el token
      emit(LoginInitial());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
