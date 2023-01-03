import 'package:get/get.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/review.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class Tab2ReviewProductDetailController extends GetxController {
  uApiProvider _apiProvider = uApiProvider();

  RxList<Review> reviews = <Review>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    int productId = Get.arguments;
    //print('productId in Tab2ReviewProductDetailController $productId');
    reviews.value = await _apiProvider.getProductReviews(productId: productId, offset: 0, limit: 20);
  }

  deleteReviewPressed(Review review) async {
    StatusModel status = await _apiProvider.deleteReview(reviewId: review.id);
    if (status.statusCode == 200) {
      mSnackbar(message: '삭제 되었습니다.');
    } else {
      mSnackbar(message: '오류: ' + status.message);
    }
  }
}
