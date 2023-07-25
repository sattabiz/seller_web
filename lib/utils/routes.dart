import 'package:flutter/material.dart';
import '../view/invoice_view/invoice_view.dart';
import '../view/landing_view/landing_view.dart';
import '../view/login_view/login_view.dart';
import 'package:seller_point/view/order_view/order_view.dart';
import '../view/proposal_view/proposal_view.dart';
import '../view/shipment_view/shipment_view.dart';




final Map<String, WidgetBuilder> routes = {
  '/LandingScreen': (BuildContext context) => LandingView(),
  '/login': (BuildContext context) => LoginView(),
  '/proposal': (BuildContext context) => proposalView(),
  '/order': (BuildContext context) => OrderView(),
  '/shipment': (BuildContext context) => ShipmentView(),
  '/invoice': (BuildContext context) => invoiceView(),



};