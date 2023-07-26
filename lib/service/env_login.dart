

import 'package:dio/dio.dart';

import '../config/apiUrls.dart';
import '../model/get_current_user_info_model.dart';
import '../model/login_model.dart';
import '../model/web_content_model.dart';
import '../storage/current_user_storage.dart';
import '../storage/jwt_storage_landing.dart';
class LandingPageService {
  final Dio _dio = Dio(); // Singleton instance
  final jwtStorageLandingService _jwtStorage;
  static const _defaultUser =
      String.fromEnvironment('USERNAME', defaultValue: 'defaultuser');
  static const _defaultPass =
      String.fromEnvironment('PASSWORD', defaultValue: 'defaultpass');

  LandingPageService() : _jwtStorage = jwtStorageLandingService();

  Future<LoginModel> loginCall() async {
    Map<String, dynamic> data = {
      "api_user": {"email": _defaultUser, "password": _defaultPass}
    };

    try {
      var _response = await _dio.post(
        ApiUrls.login,
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


  Future getWebContentListData() async {
  _dio.options.responseType = ResponseType.json;

  try {
    final _jwt = await jwtStorageLandingService().getJwtData();

    var response = await _dio.get(
      ApiUrls.webContent,
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

    WebContentModel webContentModel = WebContentModel.fromMap(response.data);
    await CompanyIdStorageLandingService().saveCompanyIdData(webContentModel);

    return webContentModel;
  } catch (e) {
    throw e;
  }
}

}
