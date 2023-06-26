

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_current_user_info_model.dart';
import '../service/env_login.dart';

final getCurrentUserLandingProvider = FutureProvider.autoDispose<CurrentUserInfoModel>((ref) async {
  final autService = LandingPageService();
  try {
    CurrentUserInfoModel _userInfo = await autService.getCurrentUserInfo();
    return _userInfo;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
      }
    }
    throw e;
  }
});
