import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/get_proposals_by_state.dart';
import '../storage/jwt_storage.dart';

class GetProposalListService {
  static const String _url =
      "https://test.satta.biz/api/v1/proposals_by_state.json?proposal_state='pending'";

  Future<List<GetProposalModel>> getProposalListData() async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;
    List<GetProposalModel> _list = [];
    try {
      final _jwt = await jwtStorageService().getJwtData();
      var response = await dio.get(
        _url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );
      // debugPrint('aaaaaaa${response.data['status'].toString()}');
      // debugPrint('aaaaaaa${response.data['proposals'].toString()}');
      // debugPrint('aaaaaaa${response.data.toString()}');
      List<dynamic> data = response.data['proposals'] ?? [];
      data.forEach((element) {
        GetProposalModel? getOrderlistModel = GetProposalModel.fromMap(element);
        if (getOrderlistModel != null) {
          _list.add(getOrderlistModel);
        }
      });
    } catch (e) {
      throw e;
    }

    return _list;
  }
}

