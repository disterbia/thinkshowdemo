import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/add_product/part3_material_clothwash/controller/part3_material_clothwash_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/cloth_wash_toggle/cloth_wash_toggle.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/tab_1_detail_info_controller.dart';
import 'package:wholesaler_user/app/modules/product_detail/views/size_table_widget.dart';
import 'package:wholesaler_user/app/widgets/webview_builder_flex_height.dart';

class Tab1DetailInfo extends GetView {
  Tab1DetailInfoController ctr = Tab1DetailInfoController();
  ProductDetailController productDetailCtr = Get.put(ProductDetailController());
  AP_Part3Controller addProduct3Ctr = Get.put(AP_Part3Controller());

  Tab1DetailInfo();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Webview
                Obx(
                  () => productDetailCtr.product.value.content != null ? WebviewBuilder(htmlContent: productDetailCtr.product.value.content!) : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // Size Table
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => productDetailCtr.product.value.sizes != null ? SizeTableWidget() : Container()),
                      ),
                      // Color
                      SizedBox(height: 20),
                      Text(
                        '색상',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.colors != null ? colorsBuilder() : Container(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '소재',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.materials != null ? materialsBuilder() : Container(),
                      ),
                      SizedBox(height: 20),
                      // 두께감
                      Text(
                        '두께감',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec != null
                            ? Row(
                                children: ThickThreeButtonBuilder(selected: productDetailCtr.product.value.clothDetailSpec!.thickness!),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(height: 20),
                      // 비침
                      Text(
                        '비침',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec != null
                            ? Row(
                                children: SeethroughThreeButtonBuilder(selected: productDetailCtr.product.value.clothDetailSpec!.seeThrough!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 신축성
                      SizedBox(height: 20),
                      Text(
                        '신축성',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec != null
                            ? Row(
                                children: FlexibilityThreeButtonBuilder(selected: productDetailCtr.product.value.clothDetailSpec!.flexibility!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 안감
                      SizedBox(height: 20),
                      Text(
                        '안감',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.clothDetailSpec != null
                            ? Row(
                                children: LiningTwoButtonBuilder(isSelected: productDetailCtr.product.value.clothDetailSpec!.isLining!),
                              )
                            : SizedBox.shrink(),
                      ),
                      // 의류 관리 안내
                      SizedBox(height: 20),
                      Text(
                        '의류 관리 안내',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      // Cloth Washing tips
                      Obx(() => productDetailCtr.product.value.clothCaringGuide != null ? clothWashTipsGrid() : SizedBox.shrink()),
                      // 모델정보
                      Obx(
                        () => productDetailCtr.product.value.productModelInfo != null && productDetailCtr.product.value.productModelInfo!.modelSize != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    '모델정보',
                                    style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                                  ),
                                  SizedBox(height: 10),
                                  modelInfo(),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                      // 반품교환정보
                      SizedBox(height: 20),
                      Text(
                        '반품 및 교환',
                        style: MyTextStyles.f16.copyWith(color: MyColors.black2),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => productDetailCtr.product.value.return_exchange_info != null ? Text(productDetailCtr.product.value.return_exchange_info!) : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }

  // ThickThreeButtonBuilder [두꺼움, 중간, 얇음]
  List<Widget> ThickThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // thick '두꺼움'
    if (selected == ProductThicknessType.thick) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('두꺼움'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('두꺼움'))));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductThicknessType.middle) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('중간'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('중간'))));
    }
    buttons.add(SizedBox(width: 10));
    // thin '얇음'
    if (selected == ProductThicknessType.thin) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('얇음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('얇음'))));
    }

    return buttons;
  }

  // SeethroughThreeButtonBuilder [높음, 중간,  없음]
  List<Widget> SeethroughThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // 높음
    if (selected == ProductSeethroughType.high) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('높음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('높음'))));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductSeethroughType.middle) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('중간'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('중간'))));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (selected == ProductSeethroughType.none) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('없음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('없음'))));
    }
    return buttons;
  }

  // FlexibilityThreeButtonBuilder [높음, 중간, 없음, 밴딩]
  List<Widget> FlexibilityThreeButtonBuilder({required String selected}) {
    List<Widget> buttons = [];
    // 높음
    if (selected == ProductFlexibilityType.high) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('높음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('높음'))));
    }
    buttons.add(SizedBox(width: 10));
    // middle '중간'
    if (selected == ProductFlexibilityType.middle) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('중간'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('중간'))));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (selected == ProductFlexibilityType.none) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('없음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('없음'))));
    }
    buttons.add(SizedBox(width: 10));
    // 밴딩
    if (selected == ProductFlexibilityType.banding) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('밴딩'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('밴딩'))));
    }
    return buttons;
  }

  // LiningTwoButtonBuilder [있음, 없음]
  List<Widget> LiningTwoButtonBuilder({required bool isSelected}) {
    List<Widget> buttons = [];
    // 있음
    if (isSelected == true) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('있음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('있음'))));
    }
    buttons.add(SizedBox(width: 10));
    // 없음
    if (isSelected == false) {
      buttons.add(Expanded(child: ElevatedButton(onPressed: (() => null), child: Text('없음'))));
    } else {
      buttons.add(Expanded(child: OutlinedButton(onPressed: (() => null), child: Text('없음'))));
    }
    return buttons;
  }

// clothing_care_guide
  Widget clothWashTipsGrid() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctr.clothWashToggleInitilize();
    });

    return Container(
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        children: List.generate(8, (index) {
          return ClothWashToggle(
            clothWash: addProduct3Ctr.clothWashToggles[index],
            onPressed: () => null,
          );
        }),
      ),
    );
  }

  Widget modelInfo() {
    return Row(
      children: [
        Text('키'),
        SizedBox(width: 5),
        Text(productDetailCtr.product.value.productModelInfo!.height.toString()),
        SizedBox(width: 15),
        Text('몸무게'),
        SizedBox(width: 5),
        Text(productDetailCtr.product.value.productModelInfo!.modelWeight.toString()),
        SizedBox(width: 15),
        Text('사이즈'),
        SizedBox(width: 5),
        Text(productDetailCtr.product.value.productModelInfo!.modelSize.toString()),
      ],
    );
  }

  colorsBuilder() {
    return Row(
      children: [
        ...productDetailCtr.product.value.colors!.map(
          (color) => Row(
            children: [
              Text(color),
              SizedBox(width: 10),
            ],
          ),
        )
      ],
    );
  }

  materialsBuilder() {
    return Row(
      children: [
        ...productDetailCtr.product.value.materials!.map(
          (material) => Row(
            children: [
              Text(material.name!),
              SizedBox(width: 5),
              Text(material.ratio!.toString() + '%'),
              SizedBox(width: 15),
            ],
          ),
        )
      ],
    );
  }
}
