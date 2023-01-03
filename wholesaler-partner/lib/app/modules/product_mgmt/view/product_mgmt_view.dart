import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/tab1_ad_status/controller/tab1_ad_status_controller.dart';
import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
import 'package:wholesaler_partner/app/modules/page1_home/view/page1_home_view.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/bottom_navbar_view.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/controller/product_mgmt_controller.dart';
import 'package:wholesaler_partner/app/modules/product_mgmt/filter/product_filter_view.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_partner/app/widgets/search_field.dart';
import "package:wholesaler_user/app/constants/colors.dart";
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class ProductMgmtView extends GetView {
  ProductMgmtController ctr = Get.put(ProductMgmtController());
  Tab1AdStatusController tab1AdStatusController =
      Get.put(Tab1AdStatusController());

  bool? isTop10Page = false;
  bool? isRegisterProductPage = false;
  bool? isRegisterAdProductPage = false;
  ProductMgmtView(
      {this.isTop10Page,
      this.isRegisterProductPage,
      this.isRegisterAdProductPage}) {
    isRegisterProductPage ??= false;
    isTop10Page ??= false;
    isRegisterAdProductPage ??= false;
  }
  init() {
    ctr.init();
  }
  @override
  Widget build(BuildContext context) {
    init();
    ctr.isBottomNavbar.value=false;
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: Obx(
            () => Visibility(
              visible: ctr.isBottomNavbar.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: isTop10Page! ||
                        isRegisterProductPage! ||
                        isRegisterAdProductPage!
                    ? _addButton()
                    : ProductMgmtBottmNavbar(),
              ),
            ),
          ),
          appBar: CustomAppbar(
              isBackEnable: isRegisterAdProductPage!,
              hasHomeButton: true,
              title: '상품관리'),
          body: Obx(
            ()=>ctr.isLoading.value?LoadingWidget(): SingleChildScrollView(
              controller: ctr.scrollController.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Sort Drop down is not implemented
                    // Obx(
                    //   () => SortDropDown(
                    //     items: [SortProductDropDownItem.latest, SortProductDropDownItem.bySales],
                    //     selectedItem: ctr.selectedSortProductDropDownItem.value,
                    //     onPressed: (selectedItem) => ctr.sortDropDownChanged(selectedItem),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    ctr.products.length ==0 ?Container() :_selectAllCheckBox(),
                    SizedBox(height: 10),
                    SearchField(
                      controller: ctr.searchController,
                      hint: '상품명 검색',
                      onSubmitted: (searchText) =>
                          ctr.searchBtnPressed(searchText),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.to(() => ProductMgmtFilterView());
                          },
                          icon: Image.asset(
                            'assets/icons/ic_filter.png',
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                    ProductGridViewBuilder(
                      crossAxisCount: 3,
                      productHeight: 260,
                      products: ctr.products,
                      addProductsId: (int id) {
                        var temp =ctr.productsId;
                        if(temp.contains(id)) {
                          for (var i = 0; i < temp.length; i++) {
                            if (temp[i] == id) ctr.productsId.removeAt(i);
                          }
                        }else {
                          ctr.productsId.add(id);
                          print(ctr.productsId);
                        }

                      },
                      showBottomNavbar: () {
                        // show bottom navigation bar if at least one checkbox is checked
                        bool isAtleastOneCheckboxChecked = ctr.products
                            .any((product) => product.isChecked!.isTrue);
                        ctr.isBottomNavbar.value = isAtleastOneCheckboxChecked;
                      },
                      isShowLoadingCircle: ctr.allowCallAPI,
                      //ctr.allowCallAPI,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.offAll(() => PartnerMainView());

          return true;
        });
  }

  Widget _addButton() {
    return Obx(
      () => ctr.isAdding.value
          ? LoadingWidget()
          : SafeArea(
              child: CustomButton(
                onPressed: () async {
                  if (isRegisterAdProductPage!) {
                    await tab1AdStatusController.addToAdProduct(
                        productsId: ctr.productsId,
                        ads_application_id: ctr.applicationId);
                    // find ctr.products contain productsId in a for loop
                    for (int i = 0; i < ctr.productsId.length; i++) {
                      ctr.products
                          .firstWhere(
                              (product) => product.id == ctr.productsId[i])
                          .isChecked!
                          .value = false;
                    }
                    ctr.productsId.clear();
                    return;
                  }
                  if (!isRegisterProductPage!) {
                    await ctr.addToTop10();
                    return;
                  }
                },
                text: '추가',
              ),
            ),
    );
  }

  Widget _selectAllCheckBox() {
    return Row(
      children: [
        Obx(
          () => SizedBox(
            width: 25,
            height: 25,
            child: Checkbox(
              activeColor: MyColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(MyDimensions.circle))),
              value: ctr.isSelectAll.value,
              onChanged: (bool? value) {
                ctr.selectAllCheckbox();
              },
            ),
          ),
        ),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            ctr.selectAllCheckbox();
          },
          child: Text(
            '전체선택',
            style: MyTextStyles.f16,
          ),
        ),
      ],
    );
  }
}
