import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/apiUrls.dart';
import '../model/get_proposals_by_state.dart';
import '../service/get_services.dart';
import '../storage/current_user_storage.dart';
import 'landing_view_model.dart';
import 'order_list_view_model.dart';

final getProposalListProvider =
    FutureProvider.autoDispose<List<GetProposalModel>>((ref) async {
  final apiService = ApiService();
  //debugPrint('provider calisti');
  Response response;
  final _companyIdAsyncValue = await CompanyIdStorageLandingService().getCompanyIdData();

  try {
    response = await apiService.get(url: ApiUrls.proposal(_companyIdAsyncValue));
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
  //debugPrint(_proposalList.toString());
  return _proposalList;
});
