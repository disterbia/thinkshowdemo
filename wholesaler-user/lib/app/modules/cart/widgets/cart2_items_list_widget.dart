// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wholesaler_user/app/constants/colors.dart';
// import 'package:wholesaler_user/app/constants/styles.dart';
// import 'package:wholesaler_user/app/models/product_model.dart';
// import 'package:wholesaler_user/app/models/store_model.dart';
// import 'package:wholesaler_user/app/modules/cart/controllers/cart2_payment_controller.dart';
// import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
// import 'package:wholesaler_user/app/utils/utils.dart';
// import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

// class Cart2ItemsList extends StatelessWidget {
//   Cart2PaymentController ctr = Get.put(Cart2PaymentController());
//   Cart2ItemsList();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           () => ListView.separated(
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: ctr.orderedProducts.length,
//             shrinkWrap: true,
//             itemBuilder: (context, cartIndex) {
//               return Column(
//                 children: [
//                   _store(ctr.orderedProducts[cartIndex].store),
//                   SizedBox(height: 10),
//                   ...ctr.orderedProducts.map(
//                     (product) => _orderedProductBuilder(cartIndex, ctr.orderedProducts.indexOf(product), product),
//                   ),
//                 ],
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(height: 25);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _store(Store store) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => StoreDetailView(storeId: store.id));
//       },
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: store.imgUrl != null
//                 ? CachedNetworkImage(
//                     imageUrl: store.imgUrl!,
//                     width: 35,
//                     height: 35,
//                     fit: BoxFit.fill,
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   )
//                 : SizedBox.shrink(),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             store.name ?? '',
//             style: MyTextStyles.f16.copyWith(color: MyColors.black3),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _orderedProductBuilder(int cartIndex, int productIndex, Product product) {
//     int productPrice = product.price!;
//     int productTotalPrice = (productPrice + product.selectedOptionAddPrice!) * product.quantity!.value;
//     // Customize our ProductItemHorizontal view to match the design.
//     product.store.name = null;
//     product.price = null;
//     return Column(
//       children: [
//         Row(
//           children: [
//             ProductItemHorizontal(product: product),
//             Spacer(),
//             // Price: Right side
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   Utils.numberFormat(number: productPrice, suffix: '원'),
//                   style: MyTextStyles.f12,
//                 ),
//                 Text(
//                   Utils.numberFormat(number: productTotalPrice, suffix: '원'),
//                   style: MyTextStyles.f16,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 10)
//       ],
//     );
//   }
// }
