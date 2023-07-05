import 'package:dio/dio.dart';
import '../config/apiUrls.dart';
import '../model/get_current_user_info_model.dart';
import '../storage/jwt_storage.dart';

class UserService {

  final Dio _dio = Dio();

  Future<CurrentUserInfoModel> getCurrentUserInfo() async {
    _dio.options.responseType = ResponseType.json;

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var response = await _dio.get(
        ApiUrls.userInfo,
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

