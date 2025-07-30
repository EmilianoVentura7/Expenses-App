import '../../domain/repositories/logout_repository.dart';
import '../datasources/remote/logout_service.dart';
import '../../../../core/services/local_storage_service.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutService _logoutService;
  final LocalStorageService _localStorageService;

  LogoutRepositoryImpl(this._logoutService, this._localStorageService);

  @override
  Future<void> logout() async {
    try {
      // Llamar al servicio de logout
      await _logoutService.logout();

      // Limpiar datos locales
      await _localStorageService.clearToken();
      await _localStorageService.clearUserData();
    } catch (e) {
      // Aún así limpiar datos locales en caso de error
      await _localStorageService.clearToken();
      await _localStorageService.clearUserData();
      throw Exception('Error en el repositorio: $e');
    }
  }
}
