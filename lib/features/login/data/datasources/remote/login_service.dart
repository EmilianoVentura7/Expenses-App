import 'package:dio/dio.dart';
import 'package:expenses_app/core/network/dio_client.dart';

class LoginService {
  final DioClient dioClient;

  LoginService(this.dioClient);

  Future<Response> login(String email, String password) async {
    return await dioClient.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
  }
}
