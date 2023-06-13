import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:cashierion/model/database/database_model.dart';
import 'package:cashierion/utils/constant.dart';

class ApiManager{
  static Dio getDio(){
    var dio = Dio(BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
        responseDecoder: (responseBytes, options, responseBody) {
          if (responseBody.statusCode != 200) {
            options.responseType = ResponseType.plain;
          }

          return utf8.decode(responseBytes, allowMalformed: true);
        }));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  static Future<Uint8List> getPrediction({required Map<String, dynamic> prediction}) async {
    try {
      var dio = getDio();
      var res = await dio.post(ApiUrl.prediction, data: prediction, options: Options(responseType: ResponseType.bytes));
      return res.data;
    }  catch (e) {
      return Uint8List.fromList([]);
    }
  }
}