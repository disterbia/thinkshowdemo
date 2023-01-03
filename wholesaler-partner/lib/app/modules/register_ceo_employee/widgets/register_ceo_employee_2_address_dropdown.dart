import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/register_ceo_employee/address.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_1_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_2_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class AddressDropDown extends StatelessWidget {
  RegisterCeoEmployee2Controller ctr = Get.put(RegisterCeoEmployee2Controller());

  String title;
  String hint;
  List<Address> addresses;
  Rx<Address> selected;
  Function(Address?) onChanged;
  AddressDropDown({required this.title, required this.hint, required this.addresses, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(title),
        SizedBox(height: 6),
        // Drop down
        Container(
          height: 60,
          child: InputDecorator(
            decoration: InputDecoration(isDense: true, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)))),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<Address>(
                  value: selected.value.id != 0 ? selected.value : null, // id = 0 means empty
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  hint: Text(hint),
                  items: addresses.map<DropdownMenuItem<Address>>((Address building) {
                    bool isBuildingSelectable = ctr.isBuildingSelectable(building);

                    return DropdownMenuItem<Address>(
                      enabled: isBuildingSelectable,
                      value: building,
                      child: Text(
                        building.name!.value + (building.is_entering_store != null && building.is_entering_store! ? (' - ' + building.business_name!) : ''),
                        style: isBuildingSelectable ? MyTextStyles.f16.copyWith(color: MyColors.black2) : MyTextStyles.f16.copyWith(color: MyColors.grey2),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
