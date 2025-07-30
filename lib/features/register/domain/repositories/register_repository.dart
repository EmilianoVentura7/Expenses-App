import '../../data/models/register_model.dart';

abstract class RegisterRepository {
  Future<bool> register(RegisterModel model);
}
