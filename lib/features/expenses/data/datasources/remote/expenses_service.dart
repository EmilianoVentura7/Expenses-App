import 'package:expenses_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ExpensesService {
  final DioClient dioClient;
  ExpensesService(this.dioClient) {
    print('ExpensesService: INSTANCIADO');
  }

  Future<Response> getExpenses({
  int page = 1,
  int limit = 20,
  String? startDate,
  String? endDate,
  int? categoryId,
  String? type,
}) async {
  print('ExpensesService: getExpenses - INICIO');
  print('ExpensesService: page=$page, limit=$limit');
  
  final queryParams = <String, String>{};
  queryParams['page'] = page.toString();
  queryParams['limit'] = limit.toString();
  
  if (startDate != null && endDate != null) {
    queryParams['startDate'] = startDate;
    queryParams['endDate'] = endDate;
  }
  if (categoryId != null) {
    queryParams['category'] = categoryId.toString();
  }
  if (type != null) {
    queryParams['type'] = type;
  }
  
  print('ExpensesService: queryParams: $queryParams');
  
  try {
    final uri = Uri(path: '/expenses', queryParameters: queryParams);
    print('ExpensesService: uri: $uri');
    
    print('ExpensesService: ANTES de dioClient.get');
    final response = await dioClient.get(uri.toString());
    print('ExpensesService: DESPUÉS de dioClient.get');
    print('ExpensesService: response.data: ${response.data}');
    return response;
  } catch (e) {
    print('ExpensesService: ERROR: $e');
    rethrow;
  }
}
}
