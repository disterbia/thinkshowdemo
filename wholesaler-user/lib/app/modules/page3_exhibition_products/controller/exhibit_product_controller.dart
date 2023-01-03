import 'package:get/get.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

class ExhibitionProductsController extends GetxController {
  RxString bannerPicture = ''.obs;
  RxString title = ''.obs;
  pApiProvider _apiProvider = pApiProvider();
  int imageId = 0;
  RxList<Product> products = <Product>[].obs;

  @override
  void onInit() async {
    var arguments = Get.arguments;
    imageId = arguments['imageId'];
    await getExhibitInformation(imageId);
  }

  Future<void> getExhibitInformation(int imageId) async {
    await _apiProvider.getExhibitDetails(imageId.toString()).then((response) {
    //  print(' ressssssssssss ${response}');
      if (response['detail_img_url'] != null) {
        bannerPicture.value = (response['detail_img_url'] as String);
      } else {
        bannerPicture.value = (response['banner_img_url'] as String);
        ;
      }
      dynamic dynamicList = response['products'];

      Future.delayed(Duration(milliseconds: 1500), () {
        title.value = response['title'];

        for (var i = 0; i < dynamicList.length; i++) {
          bool isFavorite = dynamicList[i]['is_favorite'];
          products.add(Product(
              id: dynamicList[i]['id'],
              isLiked: isFavorite.obs,
              price: dynamicList[i]['price'],
              title: dynamicList[i]['product_name'],
              imgUrl: dynamicList[i]['thumbnail_image_url'],
              store: Store(id: dynamicList[i]['store_id'])));
        }
      });
    });
  }
}
