import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/get_current_user_info_model.dart';
import '../model/get_order_list_model.dart';
import '../storage/current_user_storage.dart';
import '../storage/jwt_storage.dart';

class UserService {
  static const String _url =
      "https://test.satta.biz/api/v1/current_user_info.json";

  final Dio _dio = Dio();
  final secureStorageService = SecureStorageService();

  Future<CurrentUserInfoModel> getCurrentUserInfo() async {
    _dio.options.responseType = ResponseType.json;

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var response = await _dio.get(
        _url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      secureStorageService.saveName(
        response.data['company']['name'],
      );
      secureStorageService.saveFullName(
        response.data['current_user']['full_name'],
      );

      if (response.statusCode == 200) {
        CurrentUserInfoModel currentUserInfo =
            CurrentUserInfoModel.fromMap(response.data);
        return currentUserInfo;
      } else {
        throw DioException(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
