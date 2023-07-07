import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/web_content_model.dart';
import '../service/env_login.dart';

final getLandingViewContentProvider = FutureProvider<WebContentModel>((ref) async {
  final landingPageService = LandingPageService();
  WebContentModel contentList;
  try {
    contentList = await landingPageService.getWebContentListData();
    return contentList;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
      }
    }
    throw e;
  }
});
