import 'package:dio/dio.dart';

abstract class BaseApiService {
  final String baseUrl = "http://103.154.176.108:3005/";

  final Dio dio = Dio();

  Future<dynamic> get({required String url});
  Future<dynamic> post({required String url, dynamic data});
  Future<dynamic> put({required String url, dynamic data});
  Future<dynamic> delete({required String url});
}
