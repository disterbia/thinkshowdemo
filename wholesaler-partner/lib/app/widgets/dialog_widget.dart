import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

DialogWidget(context, Widget content, {Widget? buttons}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: content,
            ),
            buttons ?? TwoButtons(
                rightBtnText: '확인',
                leftBtnText: '취소',
                rBtnOnPressed: () {
                  Navigator.pop(context);
                  Get.back();
                },
                lBtnOnPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    ),
  );
}
