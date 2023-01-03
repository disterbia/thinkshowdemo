import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/modules/ad/controllers/ad_controller.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/view/tab2_ad_application_view.dart';
import 'package:wholesaler_partner/app/modules/ad/views/ad_view.dart';
import 'package:wholesaler_partner/app/modules/ad_order/controllers/ad_order_controller.dart';
import 'package:wholesaler_partner/app/widgets/appbar_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/Constants/colors.dart';
import 'package:wholesaler_user/app/Constants/constants.dart';
import 'package:wholesaler_user/app/utils/utils.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/web_view_widget.dart';

class AdOrderView extends GetView {
  AdOrderController ctr = Get.put(AdOrderController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>Scaffold(
        appBar: CustomAppbar(isBackEnable: true, title: '광고'),
        body: ctr.isLoading.value ?LoadingWidget():
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Obx(
                      () => ctr.adOrderModel.value.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: ctr.adOrderModel.value.imageUrl!,
                              width: Get.width,
                              // placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                          : SizedBox.shrink(),
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Obx(
                          () => Text('광고 영역 (${ctr.adOrderModel.value.advertisementTypeName})'),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(Utils.numberFormat(number: ctr.adOrderModel.value.cost!, suffix: '원')),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    // Two Buttons: left: Apply history. Right: Ad application
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Get.to(() => AdView(), arguments: AdTabs.Tab3AdApplicationHistory.index);
                            },
                            child: Text('Application_history'.tr),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => Tab2AdApplicationView(), arguments: ctr.adOrderModel.value.id);
                            },
                            child: Text('ad_apply'.tr),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Divider
              Container(height: 6, width: double.infinity, color: MyColors.grey3),
              SizedBox(height: 10),
              // Bulletin : 공지사항
              Container(
                padding: EdgeInsets.all(15),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                child: SizedBox(
                  height: 400,
                  child: WebViewWidget(
                    url: mConst.API_BASE_URL + '/web/staff/advertisement-guide',
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
