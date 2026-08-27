// 1. Le Notifier
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityProvider extends Notifier<int> {
  @override
  int build() {
    return 1; // état initial
  }

  void increment(int stock) {
    state = state + 1;
    if (state > stock) state = stock;
  }

  void decrement() {
    state = state - 1;
    if (state < 1) state = 1;
  }

  void reset() {
    state = 1;
  }
}

// 2. Le Provider (déclaré manuellement)
final quantityProvider = NotifierProvider<QuantityProvider, int>(() {
  return QuantityProvider();
});
