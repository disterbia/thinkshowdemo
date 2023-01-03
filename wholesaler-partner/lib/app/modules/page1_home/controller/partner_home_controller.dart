import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/models/best_products_model.dart';
import 'package:wholesaler_partner/app/models/bulletin_model.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/models/product_image_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_controller.dart';
import '../../../data/api_provider.dart';
import '../../../models/main_store_model.dart';

class PartnerHomeController extends GetxController {
  Rx<MainStoreModel> mainStoreInfo = MainStoreModel().obs;
  RxList<Product> bestProducts = <Product>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Bulletin> advertisements = <Bulletin>[].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;
  bool isScrollCtrAlreadySet = false;
  int offset = 0;
  RxBool allowCallAPI = true.obs;

  RxBool isImagePicked = false.obs;
  RxBool isLoadingImage = false.obs;
  final pApiProvider _apiProvider = pApiProvider();
  XFile? _pickedImage;
  TextEditingController searchController = TextEditingController();
  RxString selectedSortProductDropDownItem = SortProductDropDownItem.latest.obs;

  RxBool isShowSplashScreen = true.obs;
  RxBool isLoading = false.obs;

  void init() async{
    print('PartnerHomeController init');
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     // isShowSplashScreen.value = false;
    isLoading.value=true;
      await getMainStore();
    await getBestProducts();
    await getAds();
    await callGetProductsAPI();
      isLoading.value=false;
     });
  }

  @override

  InternalFinalCallback<void> get onDelete => super.onDelete;

  @override
  void onInit() {
    super.onInit();
    print(
        'inside PartnerHomeController onInit isScrollCtrAlreadySet $isScrollCtrAlreadySet');
    if (isScrollCtrAlreadySet == false) {
      scrollController.value.addListener(() {
        // print('scrollController.value.addListener ${scrollController.value.offset}');
        if (scrollController.value.position.pixels ==
                scrollController.value.position.maxScrollExtent &&
            allowCallAPI.isTrue) {
          offset += mConst.limit;
          callGetProductsAPI(
              searchContent: searchController.text,
              sort: selectedSortProductDropDownItem.value,
              isScrolling: true);
        }
      });
    }

    isScrollCtrAlreadySet = true;
  }
  Future<void> uploadImageBtnPressed() async {
    print('inside uploadMainTopImage1234');
    _pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    print('_pickedImage $_pickedImage');
    if (_pickedImage != null) {
      isLoadingImage.value = true;
      ProductImageModel? imageModel =
          await _apiProvider.uploadStoreImage(pickedImage: _pickedImage!);
      print('imageModel $imageModel');
      if (imageModel != null) {
        mainStoreInfo.value.mainTopImageUrl = imageModel.url.obs;
        print('uploadMainTopImage imageModel.path  ${imageModel.path}');
        await _apiProvider
            .uploadMainTopImage(data: {'image_path': imageModel.path});
        isLoadingImage.value = false;
      }
    }
    // if (imagePath.value.isNotEmpty) {
    //   mSnackbar(message: 'image_uploaded'.tr);
    // }
    isImagePicked.value = true;
    if (_pickedImage != null) {
      isImagePicked.value = true;
      // imagePath = pickedFile.path;
    }
  }

  // Future<bool> uploadMainTopImage() async {

  // }

  Future<void> getMainStore() async {
    mainStoreInfo.value = await _apiProvider.getMainStore();
    Get.put(Dingdong3ProductsHorizController())
        .storeDingDongProducts(mainStoreInfo.value);
  }

  Future<void> getBestProducts() async {

    bestProducts.clear();
    offset = 0;
    List<BestProductsModel> bestProductsModels =
        await _apiProvider.getBestProducts();

    Store tempStore = Store(
      id: bestProductsModels.isNotEmpty
          ? bestProductsModels.first.storeId!
          : 8888,
      name: bestProductsModels.isNotEmpty
          ? bestProductsModels.first.storeName
          : 'null store name',
    );

    for (BestProductsModel bestProduct in bestProductsModels) {
      Product tempProduct = Product(
        id: bestProduct.id!,
        title: bestProduct.productName!,
        store: tempStore,
        price: bestProduct.price,
        isLiked: true.obs,
        imgUrl: bestProduct.thumbnailImageUrl!,
      );
      bestProducts.add(tempProduct);
    }
  }

  Future<void> callGetProductsAPI(
      {String? searchContent, String? sort, bool? isScrolling}) async {
    searchController.text = searchContent ?? '';
    if (isScrolling == null || isScrolling == false) {
      offset = 0;
      products.clear();
    }
    dynamic raw = await _apiProvider.getProducts(
        searchContent: searchContent,
        sort: sort,
        offset: offset,
        limit: mConst.limit);
    print(products.length);
    print(raw.length);
    for (int i = 0; i < raw.length; i++) {
      Store tempStore = Store(
        id: raw[i]['store_id'],
        name: raw[i]['store_name'],
      );
      Product tempProduct = Product(
        id: raw[i]['id'],
        title: raw[i]['product_name'],
        store: tempStore,
        price: raw[i]['price'],
        isLiked: raw[i]['is_favorite'] ? true.obs : false.obs,
        imgUrl: raw[i]['thumbnail_image_url'],
      );

      products.add(tempProduct);
    }

    if (raw.length < mConst.limit) {
      allowCallAPI.value = false;
    }
  }

  Future<void> getAds() async {
    advertisements.clear();
    dynamic raw = await _apiProvider.getAdsMainPage();
    for (int i = 0; i < raw.length; i++) {
      Bulletin tempAd = Bulletin(
        id: raw[i]['id'].toString(),
        type: BulletinType.ad,
        title: raw[i]['advertisement_card_info']['title'],
        imgURL: raw[i]['image_url'],
        cost: raw[i]['cost'],
      );
      advertisements.add(tempAd);
    }
  }

  sortDropDownChanged(String selectedItem) {
    print('selected $selectedItem');
    selectedSortProductDropDownItem.value = selectedItem;
    callGetProductsAPI(sort: selectedItem);
  }
}
