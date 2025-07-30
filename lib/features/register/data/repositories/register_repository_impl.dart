import '../models/register_model.dart';
import '../datasources/remote/register_service.dart';
import '../../domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService service;
  RegisterRepositoryImpl(this.service);

  @override
  Future<String?> register(RegisterModel model) async {
    try {
      final response = await service.register(model);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        return data['token'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
