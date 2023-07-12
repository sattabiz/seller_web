import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/apiUrls.dart';
import '../model/create_proposal_model.dart';
import '../service/post_service.dart';
import '../view/create_proposal_view/create_proposal_view_content.dart';
import '../view/create_proposal_view/create_proposal_view_table.dart';
import 'landing_view_model.dart';
import 'order_list_view_model.dart';

final createProposalProvider = FutureProvider.autoDispose<CreateProposalModel>((ref) async {
  final apiService = postService();
  Response response;
  List<FormItem> _formItems = ref.watch(formItemProvider);
  OfferModel _contentItems = ref.watch(offerModelProvider);
  final landingProviderAsyncValue = ref.watch(getLandingViewContentProvider);
            final _company_id = landingProviderAsyncValue.value;
  Map<String, dynamic> _productsAttributes = {};
    for (int i = 0; i < _formItems.length; i++) {
      _productsAttributes['$i'] = {
        "category_name": _formItems[i].category.toString(),
        "name": _formItems[i].product.toString(),
        "description": "High Quality",
        "requester_amount": _formItems[i].amount,
      };
    }
    Map<String, dynamic> data = {
        "supplier_id": _company_id!.companyId,
        "valid_days": _contentItems.validDays,
        "demand_list": {
          "delivery_date": _contentItems.deliveryDate.toString(),
          "name": _contentItems.name.toString(),
          "products_attributes": _productsAttributes 
        }
      };

  try {
    response = await apiService.post(url: ApiUrls.createProposal, data:  data);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  CreateProposalModel currentUserInfoModel =
          CreateProposalModel.fromMap(response.data);

  return currentUserInfoModel;
});
