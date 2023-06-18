import 'package:flutter/material.dart';

import '../view/invoice_view/invoice_view.dart';
import '../view/login_view/login_view.dart';
import '../view/order_view/order_view.dart';
import '../view/proposal_view/proposal_view.dart';



final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => LoginView(),
  '/orderScreen': (BuildContext context) => OrderView(),
  '/proposalScreen': (BuildContext context) => proposalView(),
  '/invoiceScreen': (BuildContext context) => invoiceView(),


};