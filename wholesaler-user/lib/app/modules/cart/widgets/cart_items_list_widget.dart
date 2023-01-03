import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/cart_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/cart/controllers/cart1_shopping_basket_controller.dart';
import 'package:wholesaler_user/app/modules/cart/widgets/circular_checkbox.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

class CartItemsList extends StatelessWidget {
  Cart1ShoppingBasketController ctr = Get.put(Cart1ShoppingBasketController());
  bool isCart1Page;
  List<Cart> cartItems;
  CartItemsList({required this.isCart1Page, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    return SafeArea(
        child: Column(
      children: [
        Obx(
          () => ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            shrinkWrap: true,
            itemBuilder: (context, cartIndex) {
              // Cart 1: show all products
              if (isCart1Page) {
                products = cartItems[cartIndex].products;
              } else {
                // Cart 2: show selected products only
                products = cartItems[cartIndex]
                    .products
                    .where(
                        (tempProduct) => tempProduct.isCheckboxSelected == true)
                    .toList();
              }

              return Column(
                children: [
                  // show store only if it contains products
                  products.length > 0
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _store(cartItems[cartIndex].store),
                        )
                      : SizedBox.shrink(),

                  // if cart 2 page, only show selected products
                  ...products.map(
                    (product) => _orderedProductBuilder(
                        cartIndex, products.indexOf(product), product),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              if (products.length > 0) {
                return Divider(height: 25);
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    ));
  }

  Widget _store(Store store) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreDetailView(storeId: store.id));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: store.imgUrl != null
                ? CachedNetworkImage(
                    imageUrl: store.imgUrl!.value,
                    width: 35,
                    height: 35,
                    fit: BoxFit.fill,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Image.asset(
                    store.imgAssetUrl,
                    width: 35,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            store.name ?? '',
            style: MyTextStyles.f16.copyWith(color: MyColors.black3),
          )
        ],
      ),
    );
  }

  Widget _orderedProductBuilder(
      int cartIndex, int productIndex, Product product) {
    int productPrice = product.price!;
    int productTotalPrice = (productPrice + product.selectedOptionAddPrice!) *
        product.quantity!.value;
    // Customize our ProductItemHorizontal view to match the design.
    Product tempProduct = Product(
      id: product.id,
      title: product.title,
      imgUrl: product.imgUrl,
      store: Store(id: product.store.id),
      selectedOptionAddPrice: product.selectedOptionAddPrice,
      OLD_option: product.OLD_option,
      quantity: product.quantity,
      imgHeight: product.imgHeight,
      imgWidth: product.imgWidth,
      showQuantityPlusMinus: product.showQuantityPlusMinus,
      cartId: product.cartId,
    );
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isCart1Page
                // Checkbox left of Product
                ? Obx(
                    () => CircularCheckbox(
                      isChecked: product.isCheckboxSelected!.value,
                      cartIndex: cartIndex,
                      productIndex: productIndex,
                      onChanged: (bool value) {
                        product.isCheckboxSelected!.toggle();
                        ctr.updateTotalPaymentPrice();
                      },
                    ),
                  )
                : SizedBox.shrink(),
            isCart1Page ? SizedBox(width: 10) : SizedBox.shrink(),
            ProductItemHorizontal(
              product: tempProduct,
              quantityPlusMinusOnPressed: (value) =>
                  ctr.quantityPlusMinusOnPressed(
                value: value,
                cartId: tempProduct.cartId!,
                qty: tempProduct.quantity!.value,
              ),
            ),
            const Spacer(),
            // Price: Right side
            FittedBox(fit: BoxFit.fitWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Utils.numberFormat(number: productPrice, suffix: '원'),
                    style: MyTextStyles.f12,
                  ),
                  Text(
                    Utils.numberFormat(number: productTotalPrice, suffix: '원'),
                    style: MyTextStyles.f16,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
