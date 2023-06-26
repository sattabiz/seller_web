

import 'package:dio/dio.dart';

import '../model/get_current_user_info_model.dart';
import '../model/login_model.dart';
import '../storage/jwt_storage_landing.dart';

class LandingPageService {
  final Dio _dio = Dio(); // Singleton instance
  final jwtStorageLandingService _jwtStorage;
  static const _defaultUser =
      String.fromEnvironment('USERNAME', defaultValue: 'defaultuser');
  static const _defaultPass =
      String.fromEnvironment('PASSWORD', defaultValue: 'defaultpass');
  static const _apiUrl =
      String.fromEnvironment('API_URL', defaultValue: 'http://localhost');

  LandingPageService() : _jwtStorage = jwtStorageLandingService();

  Future<LoginModel> loginCall() async {
    Map<String, dynamic> data = {
      "api_user": {"email": _defaultUser, "password": _defaultPass}
    };

    try {
      var _response = await _dio.post(
        _apiUrl,
        data: data,
      );

      try {
        LoginModel _result = LoginModel.fromJson(_response.data);
        await jwtStorageLandingService().saveJwtData(_result);
        return _result;
      } catch (e) {
        throw Exception("Data parsing error: $e");
      }
    } on DioException catch (e) {
      throw Exception(
          "Request failed with status: ${e.response?.statusCode}, ${e.response?.statusMessage}");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
  static const _apiUrlContent =
      String.fromEnvironment('API_URL_CONTENT', defaultValue: 'http://localhost');

  Future<CurrentUserInfoModel> getCurrentUserInfo() async {
    _dio.options.responseType = ResponseType.json;

    try {
      final _jwt = await jwtStorageLandingService().getJwtData();

      var response = await _dio.get(
        _apiUrlContent,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw DioException(
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
