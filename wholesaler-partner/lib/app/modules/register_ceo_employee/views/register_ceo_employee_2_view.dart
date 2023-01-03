import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_2_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_1_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/widgets/register_ceo_employee_2_address_dropdown.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/custom_appbar.dart';
import 'package:wholesaler_user/app/widgets/custom_button.dart';

class RegisterCeoEmployeePage2View extends GetView {
  RegisterCeoEmployee2Controller ctr = Get.put(RegisterCeoEmployee2Controller());
  RegisterCeoEmployee1Controller registerCeoEmployeeCtr = Get.put(RegisterCeoEmployee1Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppbar(
        isBackEnable: true,
        title: '회원가입 (${registerCeoEmployeeCtr.isEmployee.value ? '직원' : '대표'})',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Container(
                width: 61,
                height: 61,
                child: Image.asset('assets/icons/ic_building.png'),
              ),
              SizedBox(height: 50),
              Obx(
                () => ctr.isSearchCompanyName.isFalse ? _dropdownsBuilder() : textfieldsBuilder(),
              ),

              // Search Company - 상호명 검색
              registerCeoEmployeeCtr.isEmployee.value
                  ? Column(
                      children: [
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('상호명'),
                        ),
                        SizedBox(height: 6),
                        TextField(
                          controller: ctr.storeNameController,
                          onSubmitted: (searchValue) => ctr.searchPressed(searchValue),
                          decoration: InputDecoration(
                            hintText: '상호명으로 검색해보세요.',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),

              SizedBox(height: 30),
              // Next Button
              CustomButton(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onPressed: () {
                  ctr.nextBtnPressed();
                },
                text: '다음',
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  _dropdownsBuilder() {
    return Column(
      children: [
        // Building - 건물
        AddressDropDown(
          title: 'building'.tr,
          hint: '건물을 선택해주세요.',
          addresses: ctr.buildings,
          selected: ctr.selectedBuilding,
          onChanged: (selectedBuilding) => ctr.buildingDropdownChanged(selectedBuilding!),
        ),
        SizedBox(height: 16),
        // Building floor - 건물 층
        AddressDropDown(
          title: 'building_floor'.tr,
          hint: '층을 선택해주세요.',
          addresses: ctr.floors,
          selected: ctr.selectedFloor,
          onChanged: (selectedFloor) => ctr.floorDropdownChanged(selectedFloor!),
        ),

        SizedBox(height: 16),
        // // Appartment Number - 호수
        AddressDropDown(
          title: 'appartment_number'.tr,
          hint: '호수를 선택해주세요.',
          addresses: ctr.units,
          selected: ctr.selectedUnit,
          onChanged: (selectedUnit) => ctr.unitDropdownChanged(selectedUnit!),
        ),
      ],
    );
  }



  textfieldsBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('건물'),
        _textfieldBuilder(ctr.buildingController),
        SizedBox(height: 16),
        Text('건물 층'),
        _textfieldBuilder(ctr.floorController),
        SizedBox(height: 16),
        Text('호주수'),
        _textfieldBuilder(ctr.unitController),
      ],
    );
  }

  _textfieldBuilder(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: MyColors.grey1,
            )),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      ),
    );
  }
}
