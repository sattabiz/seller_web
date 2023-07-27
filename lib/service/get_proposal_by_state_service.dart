// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// import '../config/apiUrls.dart';
// import '../model/get_proposals_by_state.dart';
// import '../storage/jwt_storage.dart';

// class GetProposalListService {

//   Future<List<GetProposalModel>> getProposalListData() async {
//     final dio = Dio();
//     dio.options.responseType = ResponseType.json;
//     List<GetProposalModel> _list = [];
//     try {
//       final _jwt = await jwtStorageService().getJwtData();
//       var response = await dio.get(
//         ApiUrls.proposal as String,
//         options: Options(
//           headers: {
//             "Authorization": _jwt,
//           },
//         ),
//       );
//       List<dynamic> data = response.data['proposals'] ?? [];
//       data.forEach((element) {
//         GetProposalModel? getOrderlistModel = GetProposalModel.fromMap(element);
//         if (getOrderlistModel != null) {
//           _list.add(getOrderlistModel);
//         }
//       });
//     } catch (e) {
//       throw e;
//     }

//     return _list;
//   }
// }

