import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pos_app_skripsi/model/database/database_model.dart';
import 'package:pos_app_skripsi/utils/constant.dart';

class ApiManager{
  static Dio getDio(){
    var dio = Dio(BaseOptions(
        baseUrl: 'http://127.0.0.1:5000/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
        responseDecoder: (responseBytes, options, responseBody) {
          if (responseBody.statusCode != 200) {
            options.responseType = ResponseType.plain;
          }

          return utf8.decode(responseBytes, allowMalformed: true);
        }));
    return dio;
  }

  static Future<void> getPrediction({required Map<String, dynamic> prediction}) async {
    var dio = getDio();
    jsonEncode(prediction);
    var res = await dio.post(ApiUrl.prediction, data: prediction);
    print(res);
  }
}