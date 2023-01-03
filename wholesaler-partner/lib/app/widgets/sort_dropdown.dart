import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';

class SortDropDown extends StatelessWidget {
  String selectedItem;
  Function(String) onPressed;
  List<String> items;

  SortDropDown({required this.items, required this.selectedItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedItem,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: MyTextStyles.f14.copyWith(color: MyColors.black2),
        underline: null,
        onChanged: (String? newValue) => onPressed(newValue!),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
