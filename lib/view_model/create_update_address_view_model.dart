import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/address/update_address.dart';
import '../config/api_url.dart';
import '../service/post_service.dart';
import 'customer_addresses_view_model.dart';
import 'order_list_view_model.dart';

final addressFutureProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  Map<String,dynamic>? address = ref.watch(addressProvider);

  try {
    response = await apiService.post(url: ApiUrls.createUpdateAddress, data: address!);
    ref.refresh(getCustomerAddressesProvider);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  return response;
});