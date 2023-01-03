import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/models/inquiries_model.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/inquiries_page/controller/inquiry_page_controller.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/inquiries_page/view/inquiry_list_item_widget.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class InquiriesPageView extends StatelessWidget {
  InquryPageController ctr = Get.put(InquryPageController());
  InquiriesPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '문의내역'),
      body: Obx(
          ()=>ctr.isLoading.value?LoadingWidget():SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  if (ctr.inquires.isNotEmpty)
                    ...ctr.inquires.map(
                      (InquiriesPageModel inqury) => InquiryListItem(inqury),
                    )
                  else
                    Center(
                      child: Text('문의 내역이 없습니다'),
                    ),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
