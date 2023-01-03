import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/ad/tab3_ad_apply_history/point_charge_dialog/point_charge_controller.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

PointChargeDialog(context) {
  PointChargeController ctr = Get.put(PointChargeController());
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('잔여 포인트'),
                SizedBox(width: 20),
                Obx(
                  () => Text(
                    ctr.availablePoints.value + 'P',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // 충전포인트
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('충전포인트'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: ctr.pointChargeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('원'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            // 입금자명
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('입금자명'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: ctr.nameController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 14),
            // 입금계좌  333-658-9565-544
            Text('입금계좌  333-658-9565-544'),
            SizedBox(height: 14),
            // 국민은행     (주)띵쇼마켓
            Text('국민은행     (주)띵쇼마켓'),
            SizedBox(height: 14),
            TwoButtons(
              leftBtnText: '취소',
              rightBtnText: '충전신청',
              lBtnOnPressed: () {
                Get.back();
              },
              rBtnOnPressed: () => ctr.chargeBtnPressed(),
            )
          ],
        ),
      ),
    ),
  );
}
