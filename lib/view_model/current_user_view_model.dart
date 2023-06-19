

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_current_user_info_model.dart';
import '../service/get_current_user_info_service.dart';
import '../storage/current_user_storage.dart';
import 'order_list_view_model.dart';

final getCurrentUserInfoProvider = FutureProvider((ref) async {
  List _list = [];
  final autService = UserService();
  try {
    CurrentUserInfoModel _CurrentUserInfo = await autService.getCurrentUserInfo();
    String _currentUserName = await SecureStorageService().getNameData();
    String _currentUserFullName = await SecureStorageService().getFullNameData();
    _list.add(_currentUserName);
    _list.add(_currentUserFullName);
    return _list;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    throw e;
  }
});