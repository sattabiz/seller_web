import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/get_buyer_invoices_list_model.dart';
import '../storage/jwt_storage.dart';

class getInvoicesService {
  static const String _url =
      'https://test.satta.biz/api/v1/buyer_invoice_list.json?state="invoice_discounted","invoice_paid","invoice_pending","invoice_approved_dbs"&saved_to_erp=false';

  final Dio _dio = Dio();

  Future<List<GetInvoicesModel>> getInvoicesListData() async {
    _dio.options.responseType = ResponseType.json;
    List<GetInvoicesModel> _list = [];

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var response = await _dio.get(
        _url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );



      /* debugPrint('bbbbbbbbbbbbbb${response.data['status'].toString()}');
      debugPrint('bbbbbbbbbbbbbbbbbb${response.data['invoices'].toString()}');
      debugPrint('bbbbbbbbbbbbbbbbb${response.data.toString()}'); */

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