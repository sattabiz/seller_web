import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:seller_point/config/apiUrls.dart';
import '../model/shipment_model.dart';
import '../storage/jwt_storage.dart';

class GetShipmentListService{

  Future<List<Shipment>> getShipmentListService() async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;
    List<Shipment> _list = [];
    try {
      final _jwt = await jwtStorageService().getJwtData();
      var response = await dio.get(
        ApiUrls.shipment,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );
      List<dynamic> data = response.data['shipments'] ?? [];
      data.forEach((element) {
        Shipment? getShipmentListSerive = Shipment.fromMap(element);
        if (getShipmentListSerive != null) {
          _list.add(getShipmentListSerive);
        }
      });
    } catch (e) {
      throw e;
    }

    return _list;
  }
}

