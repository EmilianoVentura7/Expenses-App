import 'package:dio/dio.dart';
import '../../models/update_expense_model.dart';
import '../../../../../core/network/dio_client.dart';

class UpdateExpenseService {
  final DioClient _dioClient;

  UpdateExpenseService(this._dioClient);

  Future<Map<String, dynamic>> getExpenseById(int id) async {
    try {
      final response = await _dioClient.dio.get('/expenses/$id');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Error al obtener gasto: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  Future<Map<String, dynamic>> updateExpense(UpdateExpenseModel expense) async {
    try {
      final response = await _dioClient.dio.put(
        '/expenses/${expense.id}',
        data: expense.toJson(),
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception('Error al actualizar gasto: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  Future<void> deleteExpense(int id) async {
    try {
      print('Intentando eliminar gasto con ID: $id');
      final response = await _dioClient.dio.delete('/expenses/$id');
      print('Respuesta de eliminación: ${response.statusCode}');
    } on DioException catch (e) {
      print('Error DioException al eliminar: ${e.message}');
      print('Error completo: $e');
      throw Exception('Error al eliminar gasto: ${e.message}');
    } catch (e) {
      print('Error inesperado al eliminar: $e');
      throw Exception('Error inesperado: $e');
    }
  }
}
