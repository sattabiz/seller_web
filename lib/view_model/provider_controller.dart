import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerCountProvider = StateProvider<int>((ref) {
return 0; // Başlangıçta seçili ürün ID'si 0
});