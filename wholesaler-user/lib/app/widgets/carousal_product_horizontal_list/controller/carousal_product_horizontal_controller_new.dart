import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/data/api_provider.dart';
import 'package:wholesaler_user/app/models/product_model.dart';

class CarousalProductHorizontalControllerNew extends GetxController {
  //CarouselController indicatorSliderController = CarouselController();
  RxInt sliderIndex = 0.obs;
  RxBool isLoading = false.obs;
  uApiProvider _apiProvider = uApiProvider();

  RxList<Product> products = <Product>[].obs;
  @override
  Future<void> onInit() async {
    isLoading.value=true;
    print('CarousalProductHorizontalController init currentTab $UserHomeTabs.newProduct');
    products.value = await _apiProvider.getAdProducts(UserHomeTabs.newProduct);
    isLoading.value=false;
    super.onInit();
  }
  Future<void> init() async {
    isLoading.value=true;
    print('CarousalProductHorizontalController init currentTab $UserHomeTabs.newProduct');
    products.value = await _apiProvider.getAdProducts(UserHomeTabs.newProduct);
    isLoading.value=false;
  }
}
