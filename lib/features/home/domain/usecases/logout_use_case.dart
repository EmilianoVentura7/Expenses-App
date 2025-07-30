import '../repositories/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository _logoutRepository;

  LogoutUseCase(this._logoutRepository);

  Future<void> call() async {
    return await _logoutRepository.logout();
  }
}
