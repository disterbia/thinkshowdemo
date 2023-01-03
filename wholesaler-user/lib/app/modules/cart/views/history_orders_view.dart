// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wholesaler_user/app/constants/colors.dart';
// import 'package:wholesaler_user/app/constants/dimens.dart';
// import 'package:wholesaler_user/app/models/product_model.dart';
// import 'package:wholesaler_user/app/modules/cart/controllers/history_order_controller.dart';
// import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
// import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
// import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
// import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';

// class HistoryOrderView extends GetView<HistoryOrderController> {
//   HistoryOrderController ctr = Get.put(HistoryOrderController());
//   HistoryOrderView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(isBackEnable: true, title: 'order_history'.tr),
//       body: _historyOrderBody(),
//     );
//   }

//   Widget _historyOrderBody() => Column(
//         children: [
//           Obx(() => HorizontalChipList().getAllMainCat(categoryList: ClothCategory.getAllMainCat().map((e) => e.name).toList(), onTapped: () {})),
//           ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: ctr.products.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 Product item = ctr.products[index];
//                 return _orderItem(item);
//               })
//         ],
//       );

//   Widget _orderItem(Product item) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)), border: Border.all(color: MyColors.desc)),
//         child: ProductItemHorizontal(
//           product: item,
//         ),
//       ),
//     );
//   }
// }
