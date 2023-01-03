// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/range_date_picker/range_date_picker_controller.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

class RangeDatePicker extends GetView<RangeDatePickerController> {
  RangeDatePickerController ctr = Get.put(RangeDatePickerController());

  TextEditingController? startDateController;
  TextEditingController? endDateController;
  final Function() onSubmit;

  RangeDatePicker({required this.startDateController, required this.endDateController, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePickerDialog();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MyColors.grey8),
          color: Colors.white,
        ),
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Start date
            Expanded(
              child: Text(
                startDateController?.text ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '-',
            ),
            // End date
            Expanded(
              child: Text(
                endDateController?.text ?? "",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDatePickerDialog() {
    DateTime tempStartDate;
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            SfDateRangePicker(
              onSelectionChanged: ctr.onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(DateTime.parse(startDateController!.text), DateTime.parse(endDateController!.text)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TwoButtons(
                leftBtnText: 'cancel'.tr,
                rightBtnText: 'ok'.tr,
                lBtnOnPressed: () {
                  Get.back();
                },
                rBtnOnPressed: () {
                  startDateController?.text = DateFormat('yyyy-MM-dd').format(ctr.tempStartDate);
                  endDateController?.text = DateFormat("yyyy-MM-dd").format(ctr.tempEndDate);
                  onSubmit();
                  Get.back();
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
