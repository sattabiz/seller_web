import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/get_current_user_info_model.dart';
import '../service/get_services.dart';
import 'order_list_view_model.dart';

final getCurrentUserInfoProvider = FutureProvider.autoDispose<CurrentUserInfoModel>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.userInfo);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  CurrentUserInfoModel currentUserInfoModel =
          CurrentUserInfoModel.fromMap(response.data);

  return currentUserInfoModel;
});
