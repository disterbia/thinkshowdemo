import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/search/views/search_product_listview.dart';
import 'package:wholesaler_user/app/modules/search/views/search_result_view.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  SearchPageController ctr = Get.put(SearchPageController());
  SearchPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(isBackEnable: true, title: 'search_2'.tr),
      body: SingleChildScrollView(
        controller: ctr.scrollController.value,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(),
              Obx(
                () => ctr.showSearchProductList.isTrue ? SearchProductListview() : SearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      onChanged: (searchContent) => ctr.updateSearch(searchContent),
      onSubmitted: (searchContent) => ctr.searchProductsResult(searchContent),
      controller: ctr.searchController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.grey1, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.grey1, width: 1),
          ),
          labelText: '',
          labelStyle: const TextStyle(color: MyColors.secondaryColor, fontSize: 15),
          filled: true,
          fillColor: MyColors.grey1,
          hintStyle: const TextStyle(color: MyColors.desc),
          alignLabelWithHint: true,
          suffixIcon: InkWell(
            onTap: () => ctr.searchController.text != '' ? ctr.searchProductsResult(ctr.searchController.text) : null,
            child: Icon(
              Icons.search,
              color: MyColors.black,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0)),
    );
  }
}
