import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/top_10_products/controllers/top_10_products_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class Top10Item extends StatelessWidget {
  Top10ProductsController top10productsCtr = Get.put(Top10ProductsController());
  late int index;
  Product product;

  Top10Item({required this.product});

  @override
  Widget build(BuildContext context) {
    index = top10productsCtr.products.indexOf(product);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: ProductItemHorizontal(
              product: product,
              productNumber: ProductNumber(number: index + 1, backgroundColor: MyColors.numberColors[index]),
            ),
          ),
          // reorderToTop
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: () {
                top10productsCtr.reorderProductToTop(index);
              },
              icon: Image.asset('assets/icons/ic_circle_up.png'),
            ),
          ),
          // delete
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: () {
                top10productsCtr.deleteProduct(index);
              },
              icon: Image.asset('assets/icons/ic_trash.png'),
            ),
          ),
          // drag and drop
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/ic_reorder.png'),
            ),
          ),
        ],
      ),
    );
  }
}
