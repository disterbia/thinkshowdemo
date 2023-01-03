import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

import '../controllers/business_registration_submit_controller.dart';

class BusinessRegistrationSubmitView extends GetView<BusinessRegistrationSubmitController> {
  BusinessRegistrationSubmitController ctr = Get.put(BusinessRegistrationSubmitController());
  bool isNewSubmit; // isNewSubmit = true: register new ceo, false: editing already submitted image
  BusinessRegistrationSubmitView({required this.isNewSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, title: '직원관리'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 89),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Top(),
              _Sample(),
              _Bottom1(), // 사업자 등록증 사진 등록/변경
              _Bottom2(), // 사진 촬영방법
            ],
          ),
        ),
      ),
    );
  }

  Widget _Top() {
    return // Top Part
        Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 22),
        Text(
          'ad_center_required_docs'.tr,
          style: MyTextStyles.f18_bold,
        ),
        SizedBox(height: 22),
        Text('광고센터 이용을 위해서 사업자등록증 제출은 필수입니다.'),
        SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '사업장 등록증 등록 예시 사진',
              style: MyTextStyles.f16,
            ),
            // Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
        SizedBox(height: 22),
      ],
    );
  }

// Sample
  Widget _Sample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 15),
          height: 590,
          color: MyColors.grey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 35),
              Center(
                  child: Text(
                '사 업 자 등 록 증',
                style: MyTextStyles.f16,
              )),
              SizedBox(height: 35),
              Center(
                  child: Text(
                '등록번호 : 000-00-00000',
                style: MyTextStyles.f18_bold,
              )),
              SizedBox(height: 3),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('법인명 : 홍길동'),
              ),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('대표자 : 홍길동'),
              ),
              SizedBox(height: 28),
              // List
              SampleCenterStack('개업년월일'),
              SizedBox(height: 9),
              SampleCenterStack('사업장소재지'),
              SizedBox(height: 9),
              SampleCenterStack('본점소재지'),
              SizedBox(height: 9),
              SampleCenterStack('사업의 종류'),
              SizedBox(height: 75),
              _IDCard(),
              SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                height: 14,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: MyColors.grey4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget SampleCenterStack(String text) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 170,
              height: 14,
              child: DecoratedBox(
                decoration: BoxDecoration(color: MyColors.grey4),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Text(text),
          ),
        ],
      ),
    );
  }

  Widget _IDCard() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      height: 144,
      width: 239,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' 주민등록증'),
                      SizedBox(height: 5),
                      Text('홍길동'),
                      Text('000000-0000000'),
                    ],
                  ),
                  Container(
                    width: 68,
                    height: 80,
                    child: Image.asset('assets/images/id_card_profile_img.png'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 86,
                height: 7,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: MyColors.grey4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Bottom1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        IconTextWidget(number: '!', text: '신분증상의 주소와 사진, 주민번호뒤 7자리를 제외한 모든 정보는 잘 보이도록 촬영해주세요', textColor: MyColors.red),
        SizedBox(height: 14),
        IconTextWidget(
          number: '1',
          text: '대표자님 본인 신분증을 생년월일 6자리와 성함만 보이게 촬영해주세요',
        ),
        SizedBox(height: 14),
        IconTextWidget(number: '2', text: '띵쇼마켓 사업자 인증 요청합니다 + 신청 날짜와 휴대폰 번호를 손으로 쓴 글씨와 함께 올려주세요'),
        SizedBox(height: 14),
        IconTextWidget(number: '3', text: '법인의 경우 법인 등기부 등본도 같이 찍어주세요'),
        SizedBox(height: 30),
        Obx(() {
          return ctr.isLoading.value
              ? LoadingWidget()
              : CustomButton(
                  onPressed: () async {
                    ctr.uploadImageBtnPressed();
                  },
                  text: isNewSubmit ? 'business_registration_image_upload'.tr : 'business_registration_image_edit'.tr,
                );
        }),
        SizedBox(height: 44),
      ],
    );
  }

  Widget IconTextWidget({required String number, required String text, Color? textColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 21,
          color: Colors.orange,
          child: Center(
            child: Text(
              number,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
            child: Text(
          text,
          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
        )),
      ],
    );
  }

  Widget _Bottom2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            '사진 촬영방법',
            style: MyTextStyles.f16_bold.copyWith(color: MyColors.black3),
          ),
        ),
        SizedBox(height: 33),
        IconTextWidget(number: '1', text: '대표자님 본인 신분증을 생년월일 6자리와 성함만 보이게 촬영해주세요'),
        SizedBox(height: 14),
        IconTextWidget(number: '2', text: '띵쇼마켓 사업자 인증 요청합니다 + 신청 날짜와 휴대폰 번호를 손으로 쓴 글씨와 함께 올려주세요'),
        SizedBox(height: 14),
        IconTextWidget(
          number: '3',
          text: '법인의 경우 법인 등기부 등본도 같이 찍어주세요.',
        ),
        SizedBox(height: 46),
        Center(
          child: Text(
            '승인 절차 안내',
            style: MyTextStyles.f16_bold.copyWith(color: MyColors.black3),
          ),
        ),
        SizedBox(height: 13),
        Center(
            child: Text(
          '승인절차는 영업일 기준 최대 7일 소요가 될 수 있습니다. 최대한 빠르게 처리 될 수 있도록 노력하겠습니다.',
          style: MyTextStyles.f16.copyWith(color: MyColors.black3),
        )),
        SizedBox(height: 82),
        CustomButton(
          onPressed: () {
            Get.back();
          },
          text: 'close'.tr,
        )
      ],
    );
  }
}
