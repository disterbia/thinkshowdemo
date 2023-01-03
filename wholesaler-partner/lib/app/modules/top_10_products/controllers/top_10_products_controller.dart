import 'dart:developer';

import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/best_products_model.dart';
import 'package:wholesaler_partner/app/modules/page1_home/controller/partner_home_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/view/product_mgmt_view.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/controllers/page1_home_controller.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';

class Top10ProductsController extends GetxController {
  // PartnerHomeController partnerHomeController = Get.put(PartnerHomeController());
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  List<BestProductsModel> bestProducts = [];
  List<Product> products = <Product>[].obs;

  // reorder products by drag and drop
  void dragAndDropProduct(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = products.removeAt(oldIndex);
    products.insert(newIndex, items);
  }

  // reorder selected product to top
  void reorderProductToTop(oldIndex) {
    final items = products.removeAt(oldIndex);
    products.insert(0, items); // 0 = first item index
  }

  // delete selected product
  void deleteProduct(index) {
    final items = products.removeAt(index);
  }

  void productManual() {
    Get.to(() => ProductMgmtView(
              isTop10Page: true,
            ))!
        .then((value) => getBestProducts());
  }

  Future<void> addProductManual() async {
    isLoading.value = true;
    List<int> data = [];
    data.clear();
    for (Product item in products) {
      data.add(item.id);
    }
    var response = await apiProvider.setBestProductsTop10Page(data: {"products": data});
    isLoading.value = false;
    mSnackbar(message: response.message);
    if (response.statusCode == 200) {
      getBestProducts();
    } else {
      mSnackbar(message: response.message);
    }

    // update main page top 10 list
    // partnerHomeController.getBestProducts();
  }

  @override
  void onInit() {
    super.onInit();
    getBestProducts();
  }

  getBestProducts() {
    isLoading.value = true;
    apiProvider.getBestProducts().then((response) {
      bestProducts.clear();
      products.clear();

      bestProducts.addAll(response);
      for (var element in bestProducts) {
        log('best id: ${element.id}');
        products.add(
          Product(
            id: element.id!,
            title: element.productName!,
            price: element.price,
            imgHeight: 100,
            imgWidth: 80,
            imgUrl: element.thumbnailImageUrl!,
            store: Store(
              id: element.storeId!,
              name: null,
            ),
          ),
        );
      }

      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      mSnackbar(message: error.toString());
    });
  }

  getBestProductsRecommended() {
    isLoading.value = true;
    apiProvider.getBestProductsRecommended().then((response) {
      bestProducts.clear();
      // products.clear();

      bestProducts.addAll(response);
      for (var element in bestProducts) {
        products.add(
          Product(
            id: element.id!,
            title: element.productName!,
            price: element.price,
            imgHeight: 100,
            imgWidth: 80,
            imgUrl: element.thumbnailImageUrl!,
            store: Store(
              id: element.storeId!,
              name: element.storeName,
            ),
          ),
        );
      }

      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      mSnackbar(message: error.toString());
    });
  }
}
