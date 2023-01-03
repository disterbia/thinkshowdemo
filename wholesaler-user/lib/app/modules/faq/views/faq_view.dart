import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/modules/faq/controllers/faq_controller.dart';
import 'package:wholesaler_user/app/modules/faq/views/widget/question_item.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';

class FaqView extends GetView<FaqController> {
  FaqController ctr = Get.put(FaqController());

  FaqView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: _body(),
      appBar: CustomAppbar(isBackEnable: true, title: 'FAQ'.tr),
    );
  }

  Widget _body() {
    return _Listview1Builder();
  }

  _Listview1Builder() {
    print('inside _Listview1Builder ctr.faqList.length ${ctr.faqList.length}');
    return Obx(
      ()=>ctr.isLoading.value?LoadingWidget(): SingleChildScrollView(
        child:  Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ctr.faqList.length,
              separatorBuilder: (BuildContext context, int index1) => SizedBox(height: 10),
              itemBuilder: (BuildContext context, int index1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ctr.faqList[index1].faqCategoryName!,
                      style: MyTextStyles.f16_bold.copyWith(color: MyColors.black3),
                    ),
                    SizedBox(height: 10),
                    _Listview2Builder(index1),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),

      ),
    );
  }

  _Listview2Builder(int index1) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ctr.faqList[index1].questions!.length,
      separatorBuilder: (BuildContext context, int index2) => SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index2) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaqQuestionWidget(questionItem: ctr.faqList[index1].questions![index2]),
          ],
        );
      },
    );
  }
}
