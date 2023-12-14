import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/utils/widget_helper.dart';
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


final invoiceIndexProvider = StateProvider<GetInvoicesModel>((ref) {
  return GetInvoicesModel();
},);

final invoiceCurrenciesIndexProvider = StateProvider<String?>((ref) {
  GetInvoicesModel invoice = ref.watch(invoiceIndexProvider);
  List<Product> products = invoice.products!;
  List<String> currencies = [];
  for(Product product in products){
    if(product.currencyCode != "TRY"){
      if(product.currencyCode == "USD"){
        currencies.add("USD(\$)= ${invoice.foreignCurrencies?['1']}");
      }else if(product.currencyCode == "EUR"){
        currencies.add("Euro(€)= ${invoice.foreignCurrencies?['2']}");
      }else{
        currencies.add("GBP(£)= ${invoice.foreignCurrencies?['3']}");
      }
    }
  }
  currencies = currencies.toSet().toList();                  //It helps to deduplicate multiple occurrences of the same data.   
  if(currencies.isNotEmpty){                                 //Check of the if block above
    String currenciesValue = currencies.join(", ");          //It serves to convert the List<String> currencies into a string
    String currenciesMessage = "${formattedDate(invoice.invoiceDate.toString())} itibari ile TCMB satış kuru; $currenciesValue";
    return currenciesMessage;
  }else{
    return "";
  } 
},);