import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';

class Tab1DetailInfoController extends GetxController {
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());
  AP_Part3Controller addProduct3Ctr = Get.put(AP_Part3Controller());

  void clothWashToggleInitilize() {
    addProduct3Ctr.clothWashToggles.forEach((clothWash) {
      if (clothWash.id == ClothCareGuideId.handWash) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isHandWash!;
      } else if (clothWash.id == ClothCareGuideId.dryCleaning) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isDryCleaning!;
      } else if (clothWash.id == ClothCareGuideId.noBleach) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isNotBleash!;
      } else if (clothWash.id == ClothCareGuideId.noIron) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isNotIroning!;
      } else if (clothWash.id == ClothCareGuideId.noLaundryMachine) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isNotMachineWash!;
      } else if (clothWash.id == ClothCareGuideId.separateWash) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isSingleWash!;
      } else if (clothWash.id == ClothCareGuideId.waterWash) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isWaterWash!;
      } else if (clothWash.id == ClothCareGuideId.woolWash) {
        clothWash.isActive.value = productDetailCtr.product.value.clothCaringGuide!.isWoolWash!;
      }
    });
  }
}
