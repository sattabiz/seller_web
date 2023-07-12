import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_list_view_model.dart';

class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

final counterProvider = ChangeNotifierProvider<CounterNotifier>((ref) {
  debugPrint('aaaaa');
  ref.refresh(getOrderListProvider);
  ref.read(getOrderListProvider.future);
  return CounterNotifier();
});
