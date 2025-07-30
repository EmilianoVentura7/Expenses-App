import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_use_case.dart';
import '../../domain/entities/register_entity.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final entity = RegisterEntity(name: name, email: email, password: password);
    final success = await registerUseCase(entity);
    if (success) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterError('Error al registrar usuario'));
    }
  }
}
