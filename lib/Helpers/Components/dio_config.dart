import 'package:dio/dio.dart';
import 'package:flutter_application/Helpers/Server/server.dart';

class DioConfiguration {
  static BaseOptions options = BaseOptions(
      baseUrl: serverUrl + api + v2,
      sendTimeout: Duration(milliseconds:3000),
      connectTimeout: Duration(milliseconds:3000),
      receiveTimeout: Duration(milliseconds:3000),
    );
  static late Dio dio = Dio(options);
 
}