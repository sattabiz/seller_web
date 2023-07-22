import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/apiUrls.dart';
import '../model/get_proposals_by_state.dart';
import '../service/get_services.dart';
import 'landing_view_model.dart';
import 'order_list_view_model.dart';

final proposalListview = FutureProvider.autoDispose<List<GetProposalModel>>((ref) async {
  final apiService = ApiService();
  //debugPrint('provider calisti');
  Response response;
  final landingViewResponse = ref.watch(getLandingViewContentProvider).value;
  final supplier_id = landingViewResponse!.companyId;

  try {
    response = await apiService.get(url: ApiUrls.proposal);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  List<GetProposalModel> _proposalList = [];
  if (response.data['proposals'] != null) {
    _proposalList = (response.data['proposals'] as List)
        .map((e) => GetProposalModel.fromMap(e))
        .toList();
  }
  ref.onDispose(() {_proposalList.remove(_proposalList);});
  //debugPrint(_proposalList.toString());
  return _proposalList; 
});