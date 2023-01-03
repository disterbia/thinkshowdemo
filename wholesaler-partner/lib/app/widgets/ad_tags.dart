import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_chip_widget.dart';
import 'package:wholesaler_user/app/widgets/category_tags/category_tag_controller.dart';

class AdTags extends GetView {
  CategoryTagController ctr = Get.put(CategoryTagController());
  List<String> chipsName;
  Function(int) onTap;
  AdTags({required this.chipsName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoryTagController());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.end,
          children: [
            for (int i = 0; i < chipsName.length; i++)
              ChipWidget(
                  title: chipsName[i],
                  onTap: () {
                    onTap(i);
                    ctr.selectedMainCatIndex.value = i;
                  },
                  isSelected: i == ctr.selectedMainCatIndex.value ? true : false),
          ],
        ),
      ),
    );
  }
}
