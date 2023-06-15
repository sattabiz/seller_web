import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/get_order_list_model.dart';
import '../storage/jwt_storage.dart';


class getOrderlistService {
  static const String _url =
      "https://test.satta.biz/api/v1/order_list.json?state='order_approved'&with_po=1";

  final Dio _dio = Dio();

  Future<List<GetOrderlistModel>> getOrderlistData() async {
    _dio.options.responseType = ResponseType.json;
    List<GetOrderlistModel> _list = [];

    try {
      final _jwt = await jwtStorageService().getJwtData();
      debugPrint(_jwt);

      var response = await _dio.get(
        _url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw DioError(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }

      List data = response.data['order'];
      data.forEach((element) {
        GetOrderlistModel getOrderlistModel =
            GetOrderlistModel.fromMap(element);
        _list.add(getOrderlistModel);
      });
    } catch (e) {
      throw e;
    }

    return _list;
  }
}





/* import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/get_order_list_model.dart';
import '../storage/jwt_storage.dart';

class GetOrderlistService {
  static const String _url =
      "https://test.satta.biz/api/v1/order_list.json?state='order_approved'&with_po=1";
  final JwtStorageService _jwtStorageService = JwtStorageService();

  Future<List<GetOrderlistModel>> getOrderlistData() async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;
    List<GetOrderlistModel> _list = [];
    final _jwt = await _jwtStorageService.getJwtData();

    debugPrint('$_jwt dsdfsdgdfghdf');

    var response = await dio.get(
      _url,
      options: Options(
        headers: {
          "Authorization": "Bearer $_jwt",
        },
      ),
    );

    List data = response.data['order'];
    data.forEach((element) {
      GetOrderlistModel getOrderlistModel =
          GetOrderlistModel.fromMap(element);
      _list.add(getOrderlistModel);
    });
    GetOrderlistModel firstOrder = _list[0];

    return _list;
  }
} */