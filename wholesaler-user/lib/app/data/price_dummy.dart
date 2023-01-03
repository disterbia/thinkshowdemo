import 'dart:math';

class ProductPrices {
  /// Product Title Builder
  static int dummy() {
    List<int> prices = [15000, 50000, 62000, 89000, 40000, 15000];
    return prices[Random().nextInt(prices.length)];
  }
}
