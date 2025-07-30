import '../../data/models/register_model.dart';

abstract class RegisterRepository {
  Future<String?> register(RegisterModel model);
}
