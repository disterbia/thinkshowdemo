import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wholesaler_partner/app/models/product_inquiry_model.dart';
import 'package:wholesaler_partner/app/modules/product_inquiry_detail/controller/product_inquiry_detail_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/text_button.dart';

class ProductInquiryDetailView extends GetView<ProductInquiryDetailController> {
  ProductInquiryDetailController ctr = Get.put(ProductInquiryDetailController());
  ProductInquiry inquiry;

  ProductInquiryDetailView(this.inquiry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, hasHomeButton: true, title: '상품 문의'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: inquiry.product.imgUrl,
                fit: BoxFit.cover,
                height: inquiry.product.imgHeight,
                width: inquiry.product.imgWidth,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            SizedBox(height: 7),
            Text(
              inquiry.product.title,
              style: MyTextStyles.f14.copyWith(color: MyColors.black1),
            ),
            SizedBox(height: 20),
            _titleBuilder(inquiry.user.userName),
            SizedBox(height: 5),
            _textContainerBuilder(inquiry.question),
            SizedBox(height: 20),
            _titleBuilder('manager'.tr),
            SizedBox(height: 5),
            _textContainerBuilder(inquiry.answer ?? 'there_is_no_response'.tr),
          ],
        ),
      ),
    );
  }

  _titleBuilder(String text) {
    return Text(
      text,
      style: MyTextStyles.f16.copyWith(color: MyColors.black5),
    );
  }

  _textContainerBuilder(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}
