import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_use_case.dart';
import '../../domain/entities/register_entity.dart';
import '../../../../core/services/local_storage_service.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final LocalStorageService localStorageService;

  RegisterCubit({
    required this.registerUseCase,
    required this.localStorageService,
  }) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final entity = RegisterEntity(
        name: name,
        email: email,
        password: password,
      );
      final token = await registerUseCase(entity);

      if (token != null) {
        await localStorageService.saveToken(token);
        emit(RegisterSuccess());
      } else {
        emit(RegisterError('Error al registrar usuario'));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
