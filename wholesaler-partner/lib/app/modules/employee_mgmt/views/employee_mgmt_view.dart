import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/staff_model.dart';
import 'package:wholesaler_partner/app/modules/employee_mgmt/views/icon_text_container_widget.dart';
import 'package:wholesaler_partner/app/modules/employee_mgmt/views/number_widget.dart';
import 'package:wholesaler_partner/app/widgets/appbar_widget.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/two_buttons.dart';

import '../../../widgets/dialog_widget.dart';
import '../controllers/employee_mgmt_controller.dart';

class EmployeeMgmtView extends GetView<EmployeeMgmtController> {
  EmployeeMgmtController ctr = Get.put(EmployeeMgmtController());
  static double spaceBetweenNumberText = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackEnable: true, hasHomeButton: false, title: '직원관리'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'staff_register_approve'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // ############# Verticall Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextContainer(title: 'install_app'.tr, icon: Icons.alarm),
                  IconTextContainer(title: '회원가입\n직원선택', icon: Icons.person_add_alt),
                  IconTextContainer(title: '매장선택', icon: Icons.store),
                  IconTextContainer(title: '선택', icon: Icons.copy),
                  IconTextContainer(title: '대표자\n직원승인', icon: Icons.people_sharp),
                ],
              ),
              SizedBox(height: 40),
              // ############# Number 1, 2, 3, 3
              Row(
                children: [
                  NumberWidget2('1'),
                  SizedBox(width: spaceBetweenNumberText),
                  Text(
                    '직원이 띵쇼마켓 앱을 설치합니다.',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  NumberWidget2('2'),
                  SizedBox(width: spaceBetweenNumberText),
                  Text(
                    '직원을 선택하여 가입합니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberWidget2('3'),
                  SizedBox(width: spaceBetweenNumberText),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리 매장을 검색하고 선택, 가입합니다.',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '건물, 층, 호수 검색',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 11),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberWidget2('4'),
                  SizedBox(width: spaceBetweenNumberText),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '직원관리 화면 하단에 직원신청을 승인해주세요',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '직원은 최대 3명까지 승인이 가능합니다.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              // ############# Employee Management
              SizedBox(height: 40),
              Text(
                '직원관리',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              Obx(() {
                return ctr.isLoading.value
                    ? LoadingWidget()
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 32,
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'name'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'rank'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'approve'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'management'.tr,
                                ),
                              ),
                            ],
                            rows: ctr.staffs.map(
                              ((element) {
                                String status = element.status.toString();
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(element.name.toString())),
                                    DataCell(Text('직원')),
                                    DataCell(Text(status)),
                                    if (status == 'wait')
                                      DataCell(
                                        _outLinedButtonBuilder(
                                          text: 'approve'.tr,
                                          onPressed: () {
                                            _dialog(context, element);
                                          },
                                        ),
                                      ),
                                    if (status == 'normal')
                                      DataCell(
                                        ctr.isLoadingDelete.value
                                            ? LoadingWidget()
                                            : _outLinedButtonBuilder(
                                                text: 'delete'.tr,
                                                onPressed: () {
                                                  ctr.deleteStaff(id: element.id.toString());
                                                },
                                              ),
                                      ),
                                    if (status == 'denied')
                                      DataCell(
                                        _outLinedButtonBuilder(
                                          text: 'delete'.tr,
                                          onPressed: () {
                                            ctr.deleteStaff(id: element.id.toString());
                                          },
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            ).toList(),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _dialog(BuildContext context, StaffModel element) {
    DialogWidget(
        context,
        Text(
          '승인 / 거부?',
          style: TextStyle(fontSize: 16),
        ), buttons: Obx(() {
      return TwoButtons(
        rightBtnText: '승인',
        leftBtnText: '거부',
        rBtnOnPressed: () async {
          await ctr.setStaffStatus(id: element.id.toString(), isApproval: true);
        },
        isLoadingRight: ctr.isLoadingApprovalRight.value,
        isLoadingLeft: ctr.isLoadingApprovalLeft.value,
        lBtnOnPressed: () async {
          await ctr.setStaffStatus(id: element.id.toString(), isApproval: false);
        },
      );
    }));
  }

  _outLinedButtonBuilder({text, onPressed}) {
    return SizedBox(
      width: 70,
      height: 24,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: MyTextStyles.f14.copyWith(color: MyColors.black2),
        ),
      ),
    );
  }

  _elevatedButtonBuilder({text, onPressed}) {
    return SizedBox(
      width: 70,
      height: 24,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: MyColors.grey12,
          elevation: 0,
        ),
        child: Text(
          text,
          style: MyTextStyles.f14.copyWith(color: MyColors.black2),
        ),
      ),
    );
  }
}
