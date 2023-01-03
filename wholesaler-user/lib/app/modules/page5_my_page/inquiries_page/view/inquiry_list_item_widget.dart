import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/inquiries_model.dart';
import 'package:wholesaler_user/app/modules/page5_my_page/inquiries_page/controller/inquiry_page_controller.dart';

class InquiryListItem extends StatelessWidget {
  InquryPageController ctr = Get.put(InquryPageController());

  InquiriesPageModel inqury;
  InquiryListItem(this.inqury);

  @override
  Widget build(BuildContext context) {
    int index = ctr.inquires.indexOf(inqury);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.grey6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Question Part
            InkWell(
              onTap: () {
                if (ctr.isExapnded.contains(index)) {
                  ctr.isExapnded.remove(index);
                } else {
                  ctr.isExapnded.add(index);
                }
              },
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Spacer(),
                  //     Icon(Icons.arrow_drop_down),
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  Row(
                    children: [
                      _Q_Letter(),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          inqury.content!,
                          style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                        ),
                      ),
                      // Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        inqury.isAnswer! ? '답변완료' : '미답변',
                        style: MyTextStyles.f14.copyWith(color: MyColors.black2, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text('|'),
                      SizedBox(width: 10),
                      Text(
                        inqury.createdAt!,
                        style: MyTextStyles.f12.copyWith(color: MyColors.grey2),
                      ),
                      Spacer(),
                      // delete button
                      // SizedBox(
                      //   width: 60,
                      //   height: 25,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       '삭제',
                      //       style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       primary: MyColors.grey1,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            // Answer
            Obx(
              () => ctr.isExapnded.contains(index) && inqury.isAnswer!
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: [
                            _A_Letter(),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                inqury.answerContent ?? 'no data backend',
                                style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Q_Letter() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: MyColors.orange1,
      ),
      child: Center(
          child: Text(
        'Q',
        style: MyTextStyles.f16_bold.copyWith(color: MyColors.black2),
      )),
    );
  }

  Widget _A_Letter() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: MyColors.orange1,
      ),
      child: Center(
          child: Text(
        'A',
        style: MyTextStyles.f16_bold.copyWith(color: MyColors.white),
      )),
    );
  }
}
