import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_category_image_keyword/controller/part1_category_image_keyword_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part1_clothes_category/view/cloth_category_view.dart';
import 'package:wholesaler_partner/app/modules/add_product/view/widget/add_tag.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/input.dart';

/// 카테고리 이미지 및 키워드
class AP_Part1View extends GetView<AP_Part1Controller> {
  AP_Part1Controller ctr = Get.put(AP_Part1Controller());
  AddProductController addProductController = Get.put(AddProductController());

  double edgePadding = 15;
  var f=NumberFormat('###,###,###,###');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edgePadding),
      child: Column(
        children: [
          SizedBox(height: 20),
          _selectCategories(),
          const SizedBox(height: 12.0),
          // _errorText(),
          _selectImages(),
          const SizedBox(height: 12.0),
          InputWidget(
            labelText: 'enter_product_name'.tr,
            controller: addProductController.productNameController,
          ),
          const SizedBox(height: 12.0),
          InputWidget(
            labelText: '단가',
            keyboardType: TextInputType.number,
            controller: addProductController.priceController,
            onChanged: (value){
              if(value.isNotEmpty){
                String temp=value.replaceAll(RegExp(r'[^0-9]'),'');
                temp=f.format(int.parse(temp));
                addProductController.priceController.value = TextEditingValue(
                    text: temp,
                    selection: TextSelection.collapsed(offset: temp.toString().length));
              }
            },
          ),
          const SizedBox(height: 12.0),
          if (ctr.isPrevilage.value) _dingDongDelivery(),
          SizedBox(height: 10),
          AddTagField(
            hintText: 'enter_keywords'.tr,
            fieldController: ctr.keywordsController,
            tagList: addProductController.keywordList,
          ),
          const SizedBox(height: 12.0),
          AddTagField(
            hintText: 'enter_color'.tr,
            fieldController: ctr.colorsController,
            tagList: addProductController.colorsList,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _selectCategories() {

    return Obx(
      () => addProductController.category.value.id == -1
          ? TextField(
              readOnly: true,
              controller: ctr.categoryController,
              onTap: () {
                Get.to(() => ClothCategoryView());
              },
              decoration: InputDecoration(
                hintText: '카테고리 선택',
                labelStyle: const TextStyle(color: MyColors.black, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MyDimensions.radius),
                ),
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: MyColors.grey1, width: MyDimensions.border),
                ),
                filled: true,
                fillColor: MyColors.grey1,
                hintStyle: const TextStyle(color: MyColors.black),
                alignLabelWithHint: true,
              ),
            )
          : TextField(
              readOnly: true,
              controller: ctr.categoryController,
              onTap: () => Get.to(() => ClothCategoryView()),
              decoration: InputDecoration(
                hintText: addProductController.category.value.title +
                    ' > ' +
                    (addProductController.isEditing.isTrue
                        ? ClothCategory.getAllItems().firstWhere((element) => element.id == addProductController.productModifyModel.value.subCategoryId!).name
                        : addProductController.selectedSubCat.value.name),
                labelStyle: const TextStyle(color: MyColors.black, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MyDimensions.radius),
                ),
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: MyColors.grey1, width: MyDimensions.border),
                ),
                filled: true,
                fillColor: MyColors.grey1,
                hintStyle: const TextStyle(color: MyColors.black),
                alignLabelWithHint: true,
              ),
            ),
    );
  }

  Widget _errorText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        '이미지 등록 필수',
        style: MyTextStyles.f16.copyWith(color: MyColors.red),
      ),
    );
  }

  Widget _selectImages() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: ctr.selectImgController,
          tabs: ctr.imageTabs,
          // labelStyle: MyStyles.subtitle2,
          unselectedLabelColor: MyColors.grey8,
          indicatorColor: MyColors.primary,
          labelColor: MyColors.black,
          indicatorWeight: 2,
        ),
        SizedBox(
          width: Get.width,
          height: (Get.width - edgePadding * 2) * 4 / 3,
          child: TabBarView(
            controller: ctr.selectImgController,
            children: [
              // image 1
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey1),
                  ),
                  child: ctr.imageUrl1.value.isNotEmpty
                      ? InkWell(
                          onTap: () => ctr.uploadImageBtnPressed(),
                          child: CachedNetworkImage(
                            imageUrl: ctr.imageUrl1.value,
                            width: Get.width,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : ctr.isUploadLoading1.value
                          ? LoadingWidget()
                          : IconButton(
                              onPressed: () => ctr.uploadImageBtnPressed(),
                              padding: const EdgeInsets.all(0.0),
                              icon: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_image_icon.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    '상품 사진 등록',
                                  )
                                ],
                              ),
                            ),
                );
              }),
              // image 2
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey1),
                  ),
                  child: ctr.imageUrl2.value.isNotEmpty
                      ? InkWell(
                          onTap: () => ctr.uploadImageBtnPressed2(),
                          child: CachedNetworkImage(
                            imageUrl: ctr.imageUrl2.value,
                            width: Get.width,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : ctr.isUploadLoading2.value
                          ? LoadingWidget()
                          : IconButton(
                              onPressed: () => ctr.uploadImageBtnPressed2(),
                              padding: const EdgeInsets.all(0.0),
                              icon: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_image_icon.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    '상품 사진 등록',
                                  )
                                ],
                              ),
                            ),
                );
              }),
              // image 3
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey1),
                  ),
                  child: ctr.imageUrl3.value.isNotEmpty
                      ? InkWell(
                          onTap: () => ctr.uploadImageBtnPressed3(),
                          child: CachedNetworkImage(
                            imageUrl: ctr.imageUrl3.value,
                            width: Get.width,
                            // placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : ctr.isUploadLoading3.value
                          ? LoadingWidget()
                          : IconButton(
                              onPressed: () => ctr.uploadImageBtnPressed3(),
                              padding: const EdgeInsets.all(0.0),
                              icon: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_image_icon.png',
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    '상품 사진 등록',
                                  )
                                ],
                              ),
                            ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dingDongDelivery() {
    return GestureDetector(
      onTap: () => ctr.isDingdongDeliveryActive.toggle(),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: Obx(
              () => Checkbox(
                activeColor: MyColors.primary,
                value: ctr.isDingdongDeliveryActive.value,
                onChanged: (value) {
                  ctr.isDingdongDeliveryActive.toggle();
                },
              ),
            ),
          ),
          Text('dingdongDelivery'.tr),
        ],
      ),
    );
  }
}
