import 'package:expenses_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../../models/register_model.dart';

class RegisterService {
  final DioClient dioClient;
  RegisterService(this.dioClient);

  Future<Response> register(RegisterModel model) async {
    return await dioClient.post('/auth/register', data: model.toJson());
  }
}
