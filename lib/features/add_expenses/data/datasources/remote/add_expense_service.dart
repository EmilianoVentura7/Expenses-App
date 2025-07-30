import 'package:dio/dio.dart';
import '../../models/add_expense_model.dart';
import '../../../../../core/network/dio_client.dart';

class AddExpenseService {
  final DioClient _dioClient;

  AddExpenseService(this._dioClient);

  Future<Map<String, dynamic>> addExpense(AddExpenseModel expense) async {
    try {
      final response = await _dioClient.dio.post(
        '/expenses',
        data: expense.toJson(),
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception('Error al agregar gasto: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
