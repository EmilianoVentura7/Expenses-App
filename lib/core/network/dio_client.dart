import 'package:dio/dio.dart';
import 'package:expenses_app/core/services/local_storage_service.dart';

class DioClient {
  final Dio dio;
  final LocalStorageService localStorageService;

  DioClient({required this.dio, required this.localStorageService}) {
    dio.options.baseUrl = 'http://192.168.1.25:3000/api';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.contentType = 'application/json';
    dio.options.responseType = ResponseType.json;

    // Agregar interceptor para incluir token de autorización
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.type == DioExceptionType.connectionTimeout) {
            print('Error de timeout de conexión: ${error.message}');
            print(
              'Verifica que el servidor esté funcionando en: ${dio.options.baseUrl}',
            );
          } else if (error.type == DioExceptionType.receiveTimeout) {
            print('Error de timeout de recepción: ${error.message}');
          } else if (error.type == DioExceptionType.connectionError) {
            print('Error de conexión: ${error.message}');
            print(
              'Verifica la conectividad de red y la dirección del servidor',
            );
          } else if (error.response?.statusCode == 401) {
            print('Error de autenticación: Token inválido o expirado');
          }
          handler.next(error);
        },
      ),
    );

    // Agregar interceptor para logging en desarrollo
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    return await dio.post(path, data: data, options: options);
  }

  Future<Response> authenticate(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path, {Options? options}) async {
    return await dio.get(path, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    return await dio.patch(path, data: data, options: options);
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    return await dio.delete(path, data: data, options: options);
  }
}
