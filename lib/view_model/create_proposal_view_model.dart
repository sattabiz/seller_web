import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view_model/proposal_view_model.dart';
import '../config/api_url.dart';
import '../model/create_proposal_model.dart';
import '../service/post_service.dart';
import '../view/create_proposal_view/create_proposal_show_dialog.dart';
import '../view/create_proposal_view/create_proposal_view_content.dart';
import '../view/create_proposal_view/create_proposal_view_table.dart';
import 'landing_view_model.dart';
import 'order_list_view_model.dart';

final createProposalProvider = FutureProvider.autoDispose<CreateProposalModel>((
  ref,
) async {
  final apiService = PostService();
  Response response;
  List<FormItem> _formItems = await ref.watch(formItemProvider);
  OfferModel _contentItems = await ref.watch(offerModelProvider);
  final landingProviderAsyncValue = ref.watch(getLandingViewContentProvider);
  final _company_id = landingProviderAsyncValue.value;
  List<File> imageFile = ref.watch(imageProvider.notifier).state;

  Map<String, dynamic> _productsAttributes = {};
  for (int i = 0; i < _formItems.length; i++) {
    _productsAttributes['$i'] = {
      "category_name": _formItems[i].category.toString(),
      "name": _formItems[i].product.toString(),
      "requester_amount": _formItems[i].amount,
      "unit": "Adet",
      'image': await MultipartFile.fromFile(imageFile[0].path),
    };
  }
  debugPrint(_productsAttributes.toString());
  Map<String, dynamic> data = {
    "supplier_id": _company_id!.companyId,
    "valid_days": ref.watch(offerModelProvider).validDays,
    "demand_list": {
      "delivery_date": ref.watch(offerModelProvider).deliveryDate.toString(),
      "name": ref.watch(offerModelProvider).name.toString(),
      "include_shipment_cost":
          ref.watch(offerModelProvider).includeShipmentCost,
      "payment_due_date": ref.watch(offerModelProvider).patmentDueDate,
      "products_attributes": _productsAttributes,
    }
  };
  final formData = FormData.fromMap({"form": data});
  debugPrint('Formdata');
  debugPrint('FormData İçeriği: ${formData}');
  try {
    response = await apiService.post(url: ApiUrls.createProposal, data: data);
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
  debugPrint(response.statusCode.toString());
  debugPrint(response.statusMessage);

  CreateProposalModel createProposalresponse =
      CreateProposalModel.fromMap(response.data);

  return createProposalresponse;
});
