import '../models/home_model.dart';
import '../datasources/remote/home_service.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeService service;
  HomeRepositoryImpl(this.service);

  @override
  Future<HomeModel> getHomeData() async {
    try {
      return await service.getHomeData();
    } catch (e) {
      throw Exception('Error al obtener datos de home: $e');
    }
  }
}
