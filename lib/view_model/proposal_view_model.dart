import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_proposals_by_state.dart';
import '../service/get_proposal_by_state_service.dart';

final proposalListview = FutureProvider<List<GetProposalModel>>((ref) async {
  final orderlistservice = GetProposalListService();
  List<GetProposalModel> proposaList = [];

  try {
    proposaList = await orderlistservice.getProposalListData();
    
  } catch (error) {
    debugPrint('Hata oluştu: $error');
  }

  return proposaList;
});