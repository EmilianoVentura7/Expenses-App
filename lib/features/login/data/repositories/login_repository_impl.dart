import '../datasources/remote/login_service.dart';
import 'package:expenses_app/core/services/local_storage_service.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService _loginService;
  final LocalStorageService _storageService;

  LoginRepositoryImpl(this._loginService, this._storageService);

  @override
  Future<String> login(LoginEntity loginData) async {
    try {
      final response = await _loginService.login(
        loginData.email,
        loginData.password,
      );
      final token = response.data['token'] as String;
      await saveToken(token);
      return token;
    } catch (e) {
      throw Exception('Error en el inicio de sesión: ${e.toString()}');
    }
  }

  @override
  Future<bool> saveToken(String token) async {
    try {
      await _storageService.saveToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    // TODO: Implementar logout
  }
}
