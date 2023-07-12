import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/apiUrls.dart';
import '../model/get_buyer_invoices_list_model.dart';
import '../service/get_services.dart';
import 'order_list_view_model.dart';

final getInvoicesProvider = FutureProvider<List<GetInvoicesModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.invoices);
  } catch (error) {
    if (error is DioException) {
      if (error.response?.statusCode != 200) {
        debugPrint(error.response!.statusCode.toString());
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  List<GetInvoicesModel> _shipmentList = [];
  if (response.data['invoices'] != null) {
    _shipmentList = (response.data['invoices'] as List)
        .map((e) => GetInvoicesModel.fromMap(e))
        .toList();
  }

  return _shipmentList;
});
