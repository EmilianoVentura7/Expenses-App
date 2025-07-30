import '../models/register_model.dart';
import '../datasources/remote/register_service.dart';
import '../../domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService service;
  RegisterRepositoryImpl(this.service);

  @override
  Future<bool> register(RegisterModel model) async {
    try {
      final response = await service.register(model);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
