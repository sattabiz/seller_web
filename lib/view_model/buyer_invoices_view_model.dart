import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/get_buyer_invoices_list_model.dart';
import '../service/get_services.dart';
import '../storage/current_user_storage.dart';
import 'order_list_view_model.dart';

final getInvoicesProvider = FutureProvider.autoDispose<List<GetInvoicesModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  final _companyIdAsyncValue = await CompanyIdStorageLandingService().getCompanyIdData();
  try {
    response = await apiService.get(url: ApiUrls.invoices(_companyIdAsyncValue));
  } catch (error) {
    if (error is DioException) {
      if (error.response?.statusCode != 200) {
        debugPrint(error.response!.statusCode.toString());
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  List<GetInvoicesModel> _invoicesList = [];
  if (response.data['invoices'] != null) {
    _invoicesList = (response.data['invoices'] as List)
        .map((e) => GetInvoicesModel.fromMap(e))
        .toList();
  }
  _invoicesList.sort((a, b) => b.invoiceId!.compareTo(a.invoiceId!));
  return _invoicesList;
});
