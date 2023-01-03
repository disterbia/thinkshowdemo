import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/main_store_model.dart';
import 'package:wholesaler_partner/app/models/privilate_products_model.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/store_model.dart';

class Dingdong3ProductsHorizController extends GetxController {
  RxList<Product> dingDongProducts = <Product>[].obs;

  void storeDingDongProducts(MainStoreModel mainStoreModel) {
    dingDongProducts.clear();

    Store tempStore = Store(
      id: mainStoreModel.storeId!,
      name: mainStoreModel.storeName,
    );

    if (mainStoreModel.privilegeProducts != null) {
      for (PrivilegeProducts privProduct in mainStoreModel.privilegeProducts!) {
        Product tempProduct = Product(
          id: privProduct.id!,
          title: privProduct.productName!,
          store: tempStore,
          price: privProduct.price,
          hasBellIconAndBorder: true.obs,
          imgUrl: privProduct.thumbnailImageUrl!,
          isLiked: privProduct.isFavorite!.obs,
        );
        dingDongProducts.add(tempProduct);
      }
    }
  }
}
