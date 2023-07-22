import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/get_proposals_by_state.dart';
import '../storage/jwt_storage.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> get({required String url}) async {
    //debugPrint('servis calisti...');
    try {
      final _jwt = await jwtStorageService().getJwtData();
    
      var response = await _dio.get(
        url,
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
      List<GetProposalModel> _proposalList = [];
      if (response.data['proposals'] != null) {
        _proposalList = (response.data['proposals'] as List)
            .map((e) => GetProposalModel.fromMap(e))
            .toList();
      }
      return response;
    } catch (e) {
      throw e;
    }
  }
}
