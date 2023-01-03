import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';

class CategoryItem extends StatelessWidget {
  ClothCategory clothCategory;
  CategoryItem(this.clothCategory);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Obx(
        () => Container(
          width: 100,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius)), border: Border.all(color: clothCategory.isSelected!.isTrue ? MyColors.primary : MyColors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                clothCategory.icon,
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 6),
              Text(clothCategory.title),
            ],
          ),
        ),
      ),
    );
  }
}
