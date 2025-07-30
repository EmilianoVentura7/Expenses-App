import 'package:expenses_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../../models/home_model.dart';

class HomeService {
  final DioClient dioClient;
  HomeService(this.dioClient);

  Future<Response> getProfile() async {
    return await dioClient.get('/auth/profile');
  }

  Future<Response> getSummary() async {
    return await dioClient.get('/expenses/summary');
  }

  Future<Response> getRecentExpenses() async {
    // Solo los 4 más recientes
    return await dioClient.get('/expenses?limit=4&page=1');
  }

  Future<HomeModel> getHomeData() async {
    final profileResponse = await getProfile();
    final summaryResponse = await getSummary();
    final expensesResponse = await getRecentExpenses();

    // Manejar la respuesta de expenses correctamente
    List<dynamic> expensesList = [];
    if (expensesResponse.data != null) {
      if (expensesResponse.data is Map<String, dynamic> &&
          expensesResponse.data['expenses'] != null) {
        // Si la respuesta tiene la estructura {expenses: [...]}
        final expensesData = expensesResponse.data['expenses'];
        expensesList = expensesData is List ? expensesData : [];
      } else if (expensesResponse.data is List) {
        // Si la respuesta es directamente una lista
        expensesList = expensesResponse.data;
      }
    }

    return HomeModel.fromJson(
      profileJson: profileResponse.data,
      summaryJson: summaryResponse.data,
      expensesJson: expensesList,
    );
  }
}
