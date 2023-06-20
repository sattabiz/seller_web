import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_current_user_info_model.dart';
import '../service/get_current_user_info_service.dart';
import 'order_list_view_model.dart';

final getCurrentUserInfoProvider = FutureProvider.autoDispose<CurrentUserInfoModel>((ref) async {
  final autService = UserService();
  try {
    CurrentUserInfoModel _userInfo = await autService.getCurrentUserInfo();
    return _userInfo;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    throw e;
  }
});
