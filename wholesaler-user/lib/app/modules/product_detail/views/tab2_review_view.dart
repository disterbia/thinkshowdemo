import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/data/cache_provider.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/modules/auth/user_login_page/views/user_login_view.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_2_review_controller.dart';
import 'package:wholesaler_user/app/modules/review_detail/views/review_detail_view.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_horiz_widget.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab2ReviewView extends GetView {
  Tab2ReviewProductDetailController ctr = Get.put(Tab2ReviewProductDetailController());
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());

  Tab2ReviewView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ctr.reviews.isNotEmpty && ctr.reviews.first.writableReviewInfoModel!.is_writable!) _addReviewButton(),
            for (Review review in ctr.reviews) _reviewItemBuilder(review),
            if (ctr.reviews.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(child: Text('아직 등록된 리뷰가 없습니다')),
              ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _addReviewButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: (() {
          if (CacheProvider().getToken().isEmpty) {
            Get.to(() => User_LoginPageView());
            return;
          }
          Get.to(() => ReviewDetailView(
                isComingFromReviewPage: true,
                isEditing: false,
                selectedReviw: Review(
                    id: -1,
                    content: '',
                    rating: 0,
                    ratingType: ProductRatingType.star,
                    date: DateTime.now(),
                    createdAt: Utils.dateToString(date: DateTime.now()),
                    product: ctr.reviews.first.product,
                    reviewImageUrl: '',
                    writableReviewInfoModel: ctr.reviews.first.writableReviewInfoModel),
              ));
        }),
        child: Text(
          '리뷰 작성',
          style: MyTextStyles.f14.copyWith(color: MyColors.black1),
        ),
      ),
    );
  }

  Widget _reviewItemBuilder(Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 1, color: MyColors.grey1),
        _header(review),
        ProductItemHorizontal(product: review.product),
        SizedBox(height: 5),
        _rate(review),
        _comment(review),
        if (review.images != null)
          for (String imageUrl in review.images!) _imageBuilder(imageUrl),
        review.reviewImageUrl != null
            ? CachedNetworkImage(
                imageUrl: review.reviewImageUrl!,
                fit: BoxFit.contain,
                // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _header(Review review) {
    return Row(
      children: [
        Text(
          review.user != null ? review.user!.userName : 'null',
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            thickness: 1,
            color: MyColors.grey11,
          ),
        ),
        SizedBox(width: 10),
        Text(
          DateFormat('yyyy.MM.dd').format(review.date),
          style: MyTextStyles.f14.copyWith(color: MyColors.grey2),
        ),
        Spacer(),
        ReportEditDeleteButtons(review),
      ],
    );
  }

  Widget _rate(Review review) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: MyColors.primary,
        ),
        Text(review.rating.toString())
      ],
    );
  }

  Widget _comment(Review review) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(review.content),
    );
  }

  Widget _imageBuilder(String imageUrl) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 100,
          height: 150,
          fit: BoxFit.cover,
          // placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  ReportEditDeleteButtons(Review review) {
    if (review.isMine != null && review.isMine!) {
      // my review. Show 수정, 삭제 button
      return Row(
        children: [
          CustomButton(
            width: 50,
            backgroundColor: MyColors.grey1,
            borderColor: Colors.transparent,
            text: '수정',
            fontSize: 12,
            textColor: MyColors.black2,
            onPressed: () {
              Get.to(() => ReviewDetailView(
                    isComingFromReviewPage: true,
                    isEditing: true,
                    selectedReviw: review,
                  ));
            },
          ),
          SizedBox(width: 10),
          CustomButton(
            width: 50,
            backgroundColor: MyColors.grey1,
            borderColor: Colors.transparent,
            text: '삭제',
            fontSize: 12,
            textColor: MyColors.black2,
            onPressed: () => ctr.deleteReviewPressed(review),
          ),
        ],
      );
    } else {
      // Not my review. Show 신고하기 button
      return TextButton(
        onPressed: () => mSnackbar(message: '신고 되었습니다.'),
        child: Text(
          '신고하기',
          style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
        ),
      );
    }
  }
}
