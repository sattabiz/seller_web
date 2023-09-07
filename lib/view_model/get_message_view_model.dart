import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/message_model.dart';
import '../service/get_services.dart';
import '../view/widget/small_card/small_card.dart';
import 'order_list_view_model.dart';

final getMessageProvider =
    FutureProvider.autoDispose<GetMessageModel>((ref) async {
  final apiService = ApiService();

  Response response;
  final messageId =
       ref.watch(messageIdProvider);
  try {
    response = await apiService.get(url: ApiUrls.getMessage(messageId!));
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  /*
  debugPrint(response.data.toString());
  debugPrint(response.toString()); */

  GetMessageModel getMessage =
          GetMessageModel.fromMap(response.data);
  //debugPrint(getMessage.messages![0].body.toString());
  return getMessage;
});