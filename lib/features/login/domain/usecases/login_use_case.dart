import 'package:expenses_app/features/login/domain/entities/login_entity.dart';
import 'package:expenses_app/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<String> call(String email, String password) async {
    final loginData = LoginEntity(email: email, password: password);
    return await repository.login(loginData);
  }
}
