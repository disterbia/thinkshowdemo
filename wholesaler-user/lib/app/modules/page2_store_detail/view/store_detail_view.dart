import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/constants.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/constants/variables.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/product_number_model.dart';
import 'package:wholesaler_user/app/modules/page1_home/views/tabs/tab4_ding_dong.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/controller/store_detail_controller.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tags.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/dingdong_3products_horiz/dingdong_3products_horiz_view.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class StoreDetailView extends GetView {
  StoreDetailController ctr = Get.put(StoreDetailController());
  StoreDetailView({required int storeId}) {
    print('storeId $storeId');
    ctr.storeId.value = storeId;
    ctr.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: ctr.scrollController.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _image(),
              _starStore(),
            ],
          ),
          SizedBox(height: 10),
          // 띵동배송
          Obx(() => ctr.privilateProductsNotEmpty()
              ? Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBuilder('띵동 배송', 'view_more'.tr, () {
                      Get.to(() => Tab4DingDongView());
                    }),
                    Dingdong3ProductsHorizView(),
                    SizedBox(height: 10),
                  ],
                )
              : SizedBox()),

          // 우리매장 베스트
          titleBuilder('Best_in_store'.tr, 'manage'.tr, () {}),
          _top10Products(),
          SizedBox(height: 20),
          Divider(thickness: 10, color: MyColors.grey3),
          SizedBox(height: 20),
          // Product Category Chips
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Obx(
              () => HorizontalChipList().getAllMainCat(
                  categoryList:
                      ClothCategory.getAllMainCat().map((e) => e.name).toList(),
                  onTapped: () => ctr.updateProducts(isScrolling: false)),
            ),
          ),
          SizedBox(height: 5),
          dropdownBuilder(),
          SizedBox(height: 5),
          // Products list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ProductGridViewBuilder(
              crossAxisCount: 3,
              productHeight: 280,
              products: ctr.products,
              isShowLoadingCircle: ctr.allowCallAPI,
            ),
          ),

          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _image() {
    return Obx(
      () => ctr.mainStoreModel.value.mainTopImageUrl != null
          ? CachedNetworkImage(
              imageUrl: ctr.mainStoreModel.value.mainTopImageUrl!.value,
              width: Get.width,
              height: 400,
              fit: BoxFit.cover,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _starStore() {
    return Positioned(
      right: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Obx(
          () => ctr.mainStoreModel.value.isFavorite != null
              ? IconButton(
                  onPressed: () {
                    bool value = ctr.mainStoreModel.value.isFavorite!.value;
                    ctr.mainStoreModel.value.isFavorite!.value = !value;
                    print('new value ${!value}');
                    ctr.starIconPressed();
                  },
                  icon: ctr.mainStoreModel.value.isFavorite!.value
                      ? Icon(
                          Icons.star,
                          size: 30,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 30,
                        ),
                  color: MyColors.accentColor,
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget titleBuilder(
      String title, String buttonText, VoidCallback buttonOnPressed) {
    return Obx(
      () => ctr.top10Products.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: MyTextStyles.f16,
                  ),
                  // 관리하기 button
                  MyVars.isUserProject() == false
                      ? TextButton(
                          onPressed: buttonOnPressed,
                          child: Row(
                            children: [
                              Text(
                                buttonText,
                                style: MyTextStyles.f16,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: MyColors.black2,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  _top10Products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 우리매장 베스트
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 240,
            child: Obx(
                  () => ctr.top10Products.isNotEmpty
                  ? ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: ctr.top10Products.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 14),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 105,
                    child: ProductItemVertical(
                      product: ctr.top10Products.elementAt(index),
                      productNumber: ProductNumber(
                        number: index + 1,
                        backgroundColor:
                        MyColors.numberColors.length > index
                            ? MyColors.numberColors[index]
                            : MyColors.numberColors[0],
                      ),
                    ),
                  );
                },
              )
                  : Center(child: Text('제품을 등록해주세요.')),
            ),
          ),
        ),
      ],
    );
  }

  Widget dropdownBuilder() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => DropdownButton(
              hint: Text(ctr.dropdownItems[ctr.selectedDropdownIndex.value]),
              items: itemsBuilder(ctr.dropdownItems),
              onChanged: (String? newValue) {
                print('DropdownButton newValue $newValue');
                ctr.selectedDropdownIndex.value =
                    ctr.dropdownItems.indexOf(newValue!);
                ctr.updateProducts(isScrolling: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> itemsBuilder(List<String> itemStrings) {
    return itemStrings.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  AppBar _appbar() {
    return AppBar(
      centerTitle: true,
      leadingWidth: 100,
      backgroundColor: MyColors.white,
      title: Obx(
        () => Text(
          ctr.mainStoreModel.value.storeName ?? '',
          textAlign: TextAlign.start,
          style: const TextStyle(color: MyColors.black),
        ),
      ),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Back icon
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.black,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      elevation: 0.9,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _indicator(List<Product> products) {
    print('inisde _indicator imgList $products');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: products.asMap().entries.map((entry) {
          return GestureDetector(
              // onTap: () => ctr.indicatorSliderController.animateToPage(entry.key),
              child: Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.primary.withOpacity(
                    ctr.sliderIndex.value == entry.key ? 0.9 : 0.4)),
          ));
        }).toList(),
      ),
    );
  }

  List<Widget> top10ProductItemsBuilder({required double height}) {
    List<Widget> items = [];
    for (Product product in ctr.top10Products) {
      int index = ctr.top10Products.indexOf(product);
      items.add(
        Container(
          width: 130,
          height: height,
          padding: const EdgeInsets.only(right: 10),
          child: ProductItemVertical(
            product: product,
            productNumber: ProductNumber(
                number: index + 1,
                backgroundColor:
                    MyColors.numberColors[index > 10 ? 10 : index]),
          ),
        ),
      );
    }

    return items;
  }
}
