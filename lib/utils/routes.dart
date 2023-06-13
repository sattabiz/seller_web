import 'package:flutter/material.dart';

import '../view/login_view/login_view.dart';
import '../view/order_view/order_view.dart';


final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => LoginView(),
  '/orderScreen': (BuildContext context) => OrderView()


};