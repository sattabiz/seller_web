import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view_model/proposal_view_model.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';
import '../view/widget/big_card /chat_box/chat_box.dart';
import '../view/widget/small_card/small_card.dart';
import 'get_message_view_model.dart';
import 'order_list_view_model.dart';

final createMessageProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  final createMessageMapAsyncValue =
       ref.watch(createMessageMapProvider);
  debugPrint(json.encode(createMessageMapAsyncValue));
  final readMessageMapAsyncValue =
       ref.watch(readMessageProvider);
  debugPrint(json.encode(readMessageMapAsyncValue));
createMessageMapAsyncValue!['body'] = readMessageMapAsyncValue;

  try {
    response = await apiService.post(url: ApiUrls.createMessage, data: createMessageMapAsyncValue);
    /* await ref.refresh(getMessageProvider);
            ref.read(getMessageProvider.future); */
    //debugPrint(response.toString());
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  //debugPrint(response.statusCode.toString());

  return response.statusCode;
});