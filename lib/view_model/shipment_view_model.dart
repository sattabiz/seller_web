import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/shipment_model.dart';
import '../service/get_shipment_list_service.dart';


final shipmentProvider = FutureProvider<List<Shipment>>((ref) async {
  final shipmentListService = GetShipmentListService();
  try {
    List<Shipment> shipmentList = await shipmentListService.getShipmentListService();
    return shipmentList;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    throw e;
  }
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});