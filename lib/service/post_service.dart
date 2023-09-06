import 'package:dio/dio.dart';
import '../storage/jwt_storage.dart';

class PostService {
  static var dio = Dio();


  Future<Response> post(
      {required String url, required Map<dynamic, dynamic> data}) async {
    final dio = Dio();
    dio.options.responseType =
        ResponseType.json; //this code can make more secure
    final _jwt = await jwtStorageService().getJwtData();

    var response = await dio.post(url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
        data: data);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return response;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Proposal');
    }
  }

  Future<Response> postFormdata(
      {required String url, required FormData data}) async {
    final dio = Dio();
    dio.options.responseType =
        ResponseType.json; //this code can make more secure
    final _jwt = await jwtStorageService().getJwtData();


    var response = await dio.post(url,
        options: Options(
          headers: {
            "Authorization": _jwt,
            "Content-Type": "multipart/form-data",
          },
        ),
        data: data);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return response;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Proposal');
    }
  }

}
