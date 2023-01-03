import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/page2_store_detail/view/store_detail_view.dart';
import 'package:wholesaler_user/app/modules/search/controllers/search_page_controller.dart';
import 'package:wholesaler_user/app/widgets/product/product_item_vertical_widget.dart';

class SearchResults extends StatelessWidget {
  SearchPageController ctr = Get.put(SearchPageController());
  SearchResults();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // store results
          Obx(
            () => ctr.storeResults.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '스토어',
                        style: MyTextStyles.f14_thin,
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                : SizedBox.shrink(),
          ),
          _storeResults(),
          // keyword results
          Obx(
            () => ctr.keywordResults.isNotEmpty
                ? Column(
                    children: [
                      Text('상품', style: MyTextStyles.f14_thin),
                      SizedBox(height: 10),
                    ],
                  )
                : SizedBox.shrink(),
          ),
          _keywordResults(),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '최근 본 상품',
              style: MyTextStyles.f16,
            ),
          ),
          _RecentlyVisitedProducts(),
        ],
      ),
    );
  }

  Widget _storeResults() {
    return Obx(
      () => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ctr.storeResults.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Get.to(StoreDetailView(storeId: ctr.storeResults[index].storeId!)),
            child: Container(
              child: index < ctr.maxTotalStoreResults
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            ctr.storeResults[index].storeName!,
                            style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                          ),
                        ),
                        Divider(
                          color: MyColors.grey1,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  Widget _keywordResults() {
    return Obx(
      () => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ctr.keywordResults.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => ctr.searchProductsResult(ctr.keywordResults[index].keyword!),
            child: Container(
              child: index < ctr.maxTotalKeywordResults
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            ctr.keywordResults[index].keyword!,
                            style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                          ),
                        ),
                        Divider(
                          color: MyColors.grey1,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  Widget _RecentlyVisitedProducts() {
    return Obx(
      () => SizedBox(
        height: 270,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: ctr.recentlyVisitedProducts.length,
          itemBuilder: (BuildContext context, int index) {
            // SizedBox is added just to remove unbounded error
            return SizedBox(
              width: 100, // this is fake number. real width is calculated based on ProductItemVertical size
              child: ProductItemVertical(
                product: ctr.recentlyVisitedProducts[index],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }
}
