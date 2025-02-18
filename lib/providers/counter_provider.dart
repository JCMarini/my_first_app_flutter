import 'package:flutter_riverpod/flutter_riverpod.dart';

// Estado del contador
final counterProvider = StateProvider<int>((ref){
  return 0;
});
