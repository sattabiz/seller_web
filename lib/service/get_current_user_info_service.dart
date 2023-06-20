import 'package:dio/dio.dart';
import '../model/get_current_user_info_model.dart';
import '../storage/jwt_storage.dart';

class UserService {
  static const String _url =
      "https://test.satta.biz/api/v1/current_user_info.json";

  final Dio _dio = Dio();

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
      if (response.statusCode != 200) {
        throw DioError(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }

      CurrentUserInfoModel currentUserInfoModel =
          CurrentUserInfoModel.fromMap(response.data);

      return currentUserInfoModel;
    } catch (e) {
      throw e;
    }
  }
}

