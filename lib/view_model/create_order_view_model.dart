import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view_model/proposal_view_model.dart';
import '../config/api_url.dart';
import '../service/post_service.dart';
import '../view/widget/small_card/small_card.dart';
import 'order_list_view_model.dart';

final createOrderProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  final proposalProviderAsyncValue =
       ref.watch(getProposalListProvider).value;
  final proposalIdValue = ref.watch(proposalIndexProvider);
  //debugPrint('product proposal id value${proposalIdValue}');
  Map<String, dynamic> _productsAttributes = {};
  if(proposalProviderAsyncValue![proposalIdValue!] != null) {
      _productsAttributes['0'] = {
        "proposal_id": proposalProviderAsyncValue[proposalIdValue].proposalId.toString(),
        "product_proposal_ids": proposalProviderAsyncValue[proposalIdValue]
            .productProposals!
            .map((product) => product.productProposalId)
            .toList()
      };
  }
  try {
    response = await apiService.post(url: ApiUrls.createOrder, data: _productsAttributes);
    await ref.refresh(getProposalListProvider);
            ref.read(getProposalListProvider.future);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  //debugPrint(response.statusCode.toString());

  return response.statusCode;
});
