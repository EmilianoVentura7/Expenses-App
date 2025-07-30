import 'package:dio/dio.dart';
import '../../../../../core/network/dio_client.dart';

class LogoutService {
  final DioClient _dioClient;

  LogoutService(this._dioClient);

  Future<void> logout() async {
    try {
      await _dioClient.dio.post('/auth/logout');
    } on DioException catch (e) {
      throw Exception('Error al cerrar sesión: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
