import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/models/product_inquiry_model.dart';
import 'package:wholesaler_partner/app/modules/product_inquiry_detail/view/product_inquiry_detail_view.dart';
// import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/widgets/product/number_widget.dart';
import 'package:wholesaler_user/app/widgets/product/quantity_plus_minus_widget.dart';

import '../../modules/product_detail/controller/product_detail_controller.dart';

class ProductItemHorizontal extends StatelessWidget {
  late Product product;
  ProductNumber? productNumber;
  Review? review;
  TextStyle? titleStyle;
  ProductInquiry? inquiry;
  Function(bool)? quantityPlusMinusOnPressed;

  /// Ues for all pages except *Review pages*
  ProductItemHorizontal({
    required this.product,
    this.productNumber,
    this.quantityPlusMinusOnPressed,
  });

  /// Use for Review List, Review Detail Pages
  ProductItemHorizontal.review({required Review review, titleStyle}) {
    this.product = review.product;
    this.review = review;
    this.titleStyle = titleStyle;
  }

  /// Use for Review List, Review Detail Pages
  ProductItemHorizontal.inquiry({required ProductInquiry inquiry}) {
    this.product = inquiry.product;
    this.inquiry = inquiry;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (inquiry != null) {
          Get.to(() => ProductInquiryDetailView(inquiry!));
          return;
        }

        if (review != null) {
          log('review != null great');
          Get.to(() => ReviewDetailView(
                selectedReviw: review!,
                isComingFromReviewPage: true,
              ));
          return;
        }
        if (product.id != -1) {
          //print("${product.id}asdfasdf");
          Get.to(() => ProductDetailView(), arguments: product.id);
        }
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                // Image
                ImageBuilder(),
                // Number Top Left
                NumberTopLeftBuilder(),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                CategoryBuilder(),
                // Store Name
                StoreNameBuilder(),
                // Title
                TitleBuilder(),
                // Option
                OptionBuilder(),
                // Option with extra price
                OptionExtraPriceBuilder(),
                // Quantity plus minus buttons
                QuantityPlusMinusBuilder(),
                // Quantity
                QuantityBuilder(),
                // Price
                PriceBuilder(),
                // Total Count
                TotalCountBuilder(),
                // Sold Quantity
                SoldQuantityBuilder(),
                // Inquiry Text
                InquiryBuilder(context),
                // Review Text
                ReviewBuilder(),
                // RatingType1
                RatingType1Builder(),
                // RatingType2
                RatingType2Builder(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ImageBuilder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        fit: BoxFit.fitHeight,
        imageUrl: product.imgUrl,
        height: product.imgHeight ?? 145,
        width: product.imgWidth ?? 116,
        // placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  NumberTopLeftBuilder() {
    if (productNumber != null) {
      return NumberWidget(productNumber!);
    }
    return SizedBox.shrink();
  }

  CategoryBuilder() {
    if (product.category != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(product.category![0]),
            SizedBox(width: 3),
            Icon(
              Icons.arrow_forward_ios,
              size: 10,
            ),
            SizedBox(width: 3),
            Text(product.category![1]),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  StoreNameBuilder() {
    if (product.store.name != null) {
      return Text(product.store.name!);
    }
    return SizedBox.shrink();
  }

  TitleBuilder() {
    return Container(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          product.title,
          overflow: TextOverflow.ellipsis,
          style:
              titleStyle ?? MyTextStyles.f14.copyWith(color: MyColors.black2),
        ),
      ),
    );
  }

  OptionBuilder() {
    // Why we check product.optionExtraPrice is null or not? The reason is because on [장바구니] shopping basket page,
    // we want to show OptionExtraPriceBuilder but we don't want to show OptionBuilder.
    if (product.OLD_option != null && product.selectedOptionAddPrice == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text('option'.tr),
            SizedBox(width: 15),
            Text(product.OLD_option!),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  OptionExtraPriceBuilder() {
    if (product.selectedOptionAddPrice != null && product.OLD_option != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              product.OLD_option!,
              style: MyTextStyles.f14.copyWith(color: MyColors.black1),
            ),
            SizedBox(width: 10),
            Text(
              '+${product.selectedOptionAddPrice!.toString()}',
              style: MyTextStyles.f14.copyWith(color: MyColors.black1),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  QuantityPlusMinusBuilder() {
    if (product.showQuantityPlusMinus == true) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: QuantityPlusMinusWidget(
          quantity: product.quantity != null ? product.quantity!.value : -1,
          onTap: (isRightTapped) => quantityPlusMinusOnPressed!(isRightTapped),
        ),
      );
    }
    return SizedBox.shrink();
  }

  QuantityBuilder() {
    if (product.quantity != null && product.showQuantityPlusMinus == false) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text('quantity'.tr),
            SizedBox(width: 15),
            Text('${product.quantity!.toString()}개'),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  PriceBuilder() {
    if (product.price != null) {
      final currencyFormat = NumberFormat("#,##0", "en_US");
      String price = currencyFormat.format(product.price);
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              price,
              style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
            ),
            Text(
              '원',
              style: MyTextStyles.f14.copyWith(color: MyColors.black2),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  TotalCountBuilder() {
    if (product.totalCount != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(
              '${product.totalCount}',
              style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
            ),
            Text(
              '회',
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            )
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  SoldQuantityBuilder() {
    if (product.soldQuantity != null) {
      return Text('${product.soldQuantity.toString()}회');
    }
    return SizedBox.shrink();
  }

  InquiryBuilder(context) {
    if (inquiry != null) {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 150,
            child: Text(
              inquiry!.question,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            ),
          ),
          SizedBox(height: 5),
        ],
      );
    }
    return SizedBox.shrink();
  }

  ReviewBuilder() {
    if (review != null) {
      return Column(
        children: [
          Text(
            review!.content,
            style: MyTextStyles.f16.copyWith(color: MyColors.black2),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
        ],
      );
    }
    return SizedBox.shrink();
  }

  RatingType1Builder() {
    if (review != null && review!.ratingType == ProductRatingType.number) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          SizedBox(width: 5),
          Text(review!.rating.toString()),
        ],
      );
    }
    return SizedBox.shrink();
  }

  RatingType2Builder() {
    if (review != null && review!.ratingType == ProductRatingType.star) {
      return RatingBar.builder(
        itemSize: 20,
        ignoreGestures: true,
        initialRating: review!.rating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        // itemPadding: EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: MyColors.orange3,
        ),
        onRatingUpdate: (rating) {},
      );
    }
    return SizedBox.shrink();
  }
}
