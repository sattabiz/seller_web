import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/api_url.dart';
import '../model/login_model.dart';
import '../storage/jwt_storage.dart';

class AuthenticationService {
  final Dio _dio = Dio(); // Singleton instance
  final jwtStorageService _jwtStorage;

  AuthenticationService() : _jwtStorage = jwtStorageService();

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
    } on DioException catch (e) {
      throw Exception(
          "Request failed with status: ${e.response?.statusCode}, ${e.response?.statusMessage}");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  Future<void> logout() async {
    // Get JWT token from storage
    String jwtToken = await _jwtStorage.getJwtData();

    try {
      // Send DELETE request to logout endpoint
      var response = await _dio.delete(
        ApiUrls.logout,
        options: Options(
          headers: {
            "Authorization": jwtToken,
          },
        ),
      );

      // Check response status
      if (response.statusCode == 200) {
        // Delete JWT token from storage
        await _jwtStorage.deleteJwtData();
      } else {
        throw Exception("Logout failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          "Request failed with status: ${e.response?.statusCode}, ${e.response?.statusMessage}");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
  Future<Response> forgotPassword({Map<String, dynamic>? forgotPasswordData}) async {
    // Get JWT token from storage

    try {
      // Send DELETE request to logout endpoint
      var response = await _dio.post(
        ApiUrls.forgotPassword,
        data: forgotPasswordData
      );
      debugPrint(response.data.toString());


      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Logout failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          "Request failed with status: ${e.response?.statusCode}, ${e.response?.statusMessage}");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}