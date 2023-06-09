// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://api.newscatcherapi.com';
  final Dio dio;
  ApiService(this.dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    dio.options.headers["x-api-key"] =
        "5YiG0xMgAVAhNvhIr0Pa-W24WLquxCDxoNVdS98XgEs";
    var response = await dio.get('$_baseUrl$endPoint');
    print(response.data);
    print("data");

    return response.data;
  }
}
