import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';
import 'package:wholesaler_user/app/widgets/field_with_button.dart';
import '../controllers/question_and_answer_controller.dart';

class QuestionAndAnswerView extends GetView<QuestionAndAnswerController> {
  QuestionAndAnswerController ctr = Get.put(QuestionAndAnswerController());
  QuestionAndAnswerView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: _appbar(),
    );
  }

  AppBar _appbar() => CustomAppbar(isBackEnable: true, title: 'Q&A');
  Widget _body() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('category'.tr),
              _categoryDropdownBuilder(),
              // DropDownWidget(label: '배송문의', dropDownList: controller.dropDownItems),
              SizedBox(height: 15),
              CustomField(fieldLabel: 'Order_Number'.tr, fieldText: '주문번호를 입력해주세요.', fieldController: ctr.orderNumberController),
              SizedBox(height: 15),
              CustomField(
                maxLines: 15,
                fieldLabel: 'content'.tr,
                fieldText: 'enter_details'.tr,
                fieldController: ctr.detailsController,
              ),
              SizedBox(height: 20),
              _button()
            ],
          ),
        ),
      );

  Widget _button() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        width: Get.width,
        onPressed: () {},
        text: '등록',
      ),
    );
  }

  Widget _categoryDropdownBuilder() {
    return Container(
      height: 50,
      child: InputDecorator(
        decoration: InputDecoration(isDense: true, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            hint: Text('shipping_inquiry'.tr),
            items: <String>['shipping_inquiry'.tr, '반품방법', '기타'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (Object? value) {},
          ),
        ),
      ),
    );
  }
}
