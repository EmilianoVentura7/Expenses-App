import '../entities/register_entity.dart';
import '../repositories/register_repository.dart';
import '../../data/models/register_model.dart';

class RegisterUseCase {
  final RegisterRepository repository;
  RegisterUseCase(this.repository);

  Future<String?> call(RegisterEntity entity) async {
    final model = RegisterModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
    return await repository.register(model);
  }
}
