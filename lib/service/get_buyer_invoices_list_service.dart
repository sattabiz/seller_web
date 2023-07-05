import 'dart:convert';
import 'package:dio/dio.dart';
import '../config/apiUrls.dart';
import '../model/get_buyer_invoices_list_model.dart';
import '../storage/jwt_storage.dart';

class getInvoicesService {

  final Dio _dio = Dio();

  Future<List<GetInvoicesModel>> getInvoicesListData() async {
    _dio.options.responseType = ResponseType.json;
    List<GetInvoicesModel> _list = [];

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var response = await _dio.get(
        ApiUrls.invoices,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw DioError(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }

      List data = response.data['invoices'];
      data.forEach((element) {
        GetInvoicesModel getOrderlistModel =
            GetInvoicesModel.fromMap(element);
        _list.add(getOrderlistModel);
      });
    } catch (e) {
      throw e;
    }

    return _list;
  }
}