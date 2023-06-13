import 'package:dio/dio.dart';
import '../config/apiUrls.dart';
import '../model/login_model.dart';
import '../storage/jwt_storage.dart';


final Dio _dio = Dio(); // Singleton instance

Future<LoginModel> loginCall({
  required String email,
  required String password,
}) async {
  Map<String, dynamic> data = {
    "api_user": {"email": email, "password": password}
  };

  try {
    var _response = await _dio.post(
      ApiUrls.login,
      data: data,
    );

    try {
      LoginModel _result = LoginModel.fromJson(_response.data);
      await jwtStorageService().saveJwtData(_result);
      return _result;
    } catch (e) {
      throw Exception("Data parsing error: $e");
    }
  } on DioError catch (e) {
    throw Exception("Request failed with status: ${e.response?.statusCode}, ${e.response?.statusMessage}");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
