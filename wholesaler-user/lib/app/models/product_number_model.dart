import 'package:wholesaler_user/app/constants/colors.dart';

class ProductNumber {
  var number;
  var backgroundColor;

  ProductNumber({
    required this.number,
    required this.backgroundColor,
  });

  static List<ProductNumber> getAllOrange() {
    return [
      for (int i = 0; i < 10; i++)
        ProductNumber(
          number: i + 1,
          backgroundColor: MyColors.orange4,
        ),
    ];
  }
}
