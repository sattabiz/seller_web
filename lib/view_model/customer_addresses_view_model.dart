import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/customer_addresses_model.dart';
import '../service/get_services.dart';
import 'current_user_view_model.dart';
import 'order_list_view_model.dart';

final getCustomerAddressesProvider =
    FutureProvider.autoDispose<List<CustomerAddresses>>((ref) async {
  final apiService = ApiService();

  Response response;
  final _companyIdAsyncValue = await ref.watch(customerIdProvider);
  try {
    response = await apiService.get(url: ApiUrls.customerAddresses(_companyIdAsyncValue.toString()));
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  List<CustomerAddresses> _addresList = [];
  if (response.data['addresses'] != null) {
    _addresList = (response.data['addresses'] as List)
        .map((e) => CustomerAddresses.fromMap(e))
        .toList();
  }
  return _addresList;
});