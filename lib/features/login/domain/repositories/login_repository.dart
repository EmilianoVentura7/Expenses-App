import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<String> login(LoginEntity loginData);
  Future<bool> saveToken(String token);
  Future<void> logout();
}
