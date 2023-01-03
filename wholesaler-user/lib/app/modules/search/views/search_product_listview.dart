import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/modules/search/controllers/search_page_controller.dart';
import 'package:wholesaler_user/app/widgets/product_gridview_builder/product_gridview_builder.dart';

class SearchProductListview extends StatelessWidget {
  SearchPageController ctr = Get.put(SearchPageController());
  SearchProductListview();

  @override
  Widget build(BuildContext context) {
   // print('searchProducts length: ${ctr.searchProducts.length}');
    return SingleChildScrollView(
      // controller: ctr.scrollController.value,
      child: ProductGridViewBuilder(
        crossAxisCount: 3,
        productHeight: 280,
        products: ctr.searchProducts,
        isShowLoadingCircle: ctr.allowCallAPI,
      ),
    );
  }
}
