import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/models/add_product/option.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/product_body_size_model.dart';
import 'package:wholesaler_partner/app/models/add_product/product_body_size/size_category.dart';
import 'package:wholesaler_partner/app/modules/add_product/controller/add_product_controller.dart';
import 'package:wholesaler_partner/app/modules/add_product/part2_image_sizetable_options/controller/part2_image_sizetable_options_controller.dart';
import 'package:wholesaler_user/app/Constants/styles.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/widgets/category_tags/cloth_category.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class AP_Part2View extends GetView<AP_Part2Controller> {
  AP_Part2Controller ctr = Get.put(AP_Part2Controller());
  AddProductController addProductCtr = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            _title(),
            SizedBox(height: 5),
            // cloth pictures
            _clothPicture(),
            _sizeTable(),
            // 옵션 단가등록
            //_unitPriceCheckbox(),
            Column(
                children: [
                  // ctr.unitPriceCheckbox.isTrue &&
                  //     ctr.isOptionCheckbox.isTrue
                  //     ?
                  _optionUnitPriceChildrenNewMode()
                    //  : Container(),
                ],
              ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Enter_option'.tr,
      style: MyTextStyles.f16.copyWith(color: MyColors.black2),
    );
  }

  Widget _clothPicture() {
    return addProductCtr.category.value.id != -1
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Image.asset(
                ClothCategory.clothImages[addProductCtr.category.value.title]!,
                fit: BoxFit.fill,
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _sizeTable() {
    return addProductCtr.category != null
        ? Center(
            child: Table(
              children: [
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: Text('SIZE'),
                      ),
                    ),
                  ),
                  for (int i = 0; i < ctr.productBodySizeList.length; i++)
                    // size title: FREE, XS
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: _sizeCategory(
                        value: ctr.productBodySizeList[i].size,
                        isEnable: ctr.productBodySizeList[i].isSelected,
                      ),
                    ),
                ]),
                for (int k = 0;
                    k <
                        SizeCategory.getWithCatId(
                                addProductCtr.category.value.id)
                            .children
                            .length;
                    k++)
                  TableRow(children: [
                    // size field: ex 가슴단면
                    TableCell(
                        child: _sizeTitle(SizeCategory.getWithCatId(
                                addProductCtr.category.value.id)
                            .children[k]
                            .korean)),
                    // textfields holding values inside table
                    for (int j = 0; j < ctr.productBodySizeList.length; j++)
                      sizeFieldBuilder(
                          productBodySizeListIndex: j, sizeCategoryIndex: k),
                  ]),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  // size title: FREE, XS
  Widget _sizeCategory({required String value, required RxBool isEnable}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
          child: isEnable.value
              ? ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () => isEnable.toggle(),
                  child: Text(
                    value,
                    style: MyTextStyles.f11.copyWith(
                        color:
                            isEnable.value ? MyColors.black : MyColors.grey8),
                  ),
                )
              : OutlinedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () => isEnable.toggle(),
                  child: Text(
                    value,
                    style: MyTextStyles.f11.copyWith(
                        color:
                            isEnable.value ? MyColors.black : MyColors.grey8),
                  ),
                )),
    );
  }

  // size title: FREE, XS
  Widget _sizeTitle(String title) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Text(
        title,
        style: MyTextStyles.f12,
      ),
    ));
  }

  sizeFieldBuilder(
      {required int productBodySizeListIndex, required int sizeCategoryIndex}) {
    ctr.sizeFieldInitialize(
        productBodySizeListIndex: productBodySizeListIndex,
        sizeCategoryIndex: sizeCategoryIndex);

    return TableCell(
        child: _sizeField(
      isActive: ctr.productBodySizeList[productBodySizeListIndex].isSelected,
      productBodySizeListIndex: productBodySizeListIndex,
      sizeCategoryIndex: sizeCategoryIndex,
    ));
  }

  Widget _sizeField({
    required RxBool isActive,
    required int productBodySizeListIndex,
    required int sizeCategoryIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 35,
        child: Obx(
          () => TextField(
            textAlign: TextAlign.center,
            controller: ctr.textEditingControllers[
                productBodySizeListIndex.toString() +
                    sizeCategoryIndex.toString()],
            readOnly: !isActive.value,
            keyboardType: TextInputType.number,
            onChanged: (String value) => ctr.sizetableFieldChanged(
                value: value,
                productBodySizeListIndex: productBodySizeListIndex,
                sizeCategoryIndex: sizeCategoryIndex),
            style: isActive.value
                ? MyTextStyles.f12
                : MyTextStyles.f12.copyWith(color: MyColors.grey8),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isActive.value ? MyColors.grey9 : MyColors.grey1,
                    width: 1.0),
              ),
              border: OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            ),
          ),
        ),
      ),
    );
  }

  // 옵션 단가등록
  Widget _unitPriceCheckbox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: Checkbox(
              activeColor: MyColors.primary,
              value: ctr.isOptionCheckbox.value,
              // onChanged: (value) => null,
              onChanged: (value) => ctr.isOptionCheckbox.toggle(),
            ),
          ),
          Text('옵션 추가 금액'),
        ],
      ),
    );
  }

  _optionUnitPriceChildrenNewMode() {
  print("cccccc");
    if(addProductCtr.colorsList.isEmpty) return Center(child: Text("색상추가하세요."),);
    if (ctr.productBodySizeList.isEmpty) {
      return Center(child: Text('사이즈 추가하세요.'));
    }
    final unitPriceChildren = <Widget>[];
    addProductCtr.optionsControllers.clear();
    addProductCtr.options.clear();
    for (var colorIndex = 0;
        colorIndex < addProductCtr.colorsList.length; colorIndex++) {
      // FREE, XS, S, M, L
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'FREE')
          .isSelected
          .value) {
        print("aaaaaa");
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'FREE' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        print("bbbbbbbb");
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'FREE',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren.add(
            _unitPriceTile(colorIndex, addProductCtr.options.length, 'FREE'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'XS')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'XS' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'XS',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren.add(
            _unitPriceTile(colorIndex, addProductCtr.options.length, 'XS'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'S')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'S' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'S',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'S'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'M')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'M' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'M',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'M'));
      }
      if (ctr.productBodySizeList
          .firstWhere((element) => element.size == 'L')
          .isSelected
          .value) {
        Option? option;
        if (addProductCtr.isEditing.isTrue) {
          option = addProductCtr.productModifyModel.value.options!
              .firstWhereOrNull((option) =>
                  option.size == 'L' &&
                  option.color == addProductCtr.colorsList[colorIndex]);
        }
        addProductCtr.optionsControllers.add(TextEditingController(
            text: option != null ? option.addPrice : '0'));
        addProductCtr.options.add(Option(
            color: addProductCtr.colorsList[colorIndex],
            size: 'L',
            addPrice: option != null ? option.addPrice : '0'));
        unitPriceChildren
            .add(_unitPriceTile(colorIndex, addProductCtr.options.length, 'L'));
      }
    }

    if (addProductCtr.colorsList.isEmpty) {
      return Center(child: Text('색상 추가하세요.'));
    } else {
      return Column(
        children: unitPriceChildren,
      );
    }
  }

  Widget _unitPriceTile(int colorIndex, int currentOptionLength, String size) {
    print("ddddd");
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: MyColors.grey1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  addProductCtr.colorsList[colorIndex],
                  style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                ),
              ),
              Container(
                height: 20,
                child: VerticalDivider(
                  thickness: 1,
                  color: MyColors.subTitle,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    size,
                    style: MyTextStyles.f14.copyWith(color: MyColors.black2),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '추가금액',
                style: MyTextStyles.f14.copyWith(color: MyColors.black1),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: TextField(
                      controller: addProductCtr
                          .optionsControllers[currentOptionLength - 1],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: MyColors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _unitPriceTileEditMode(int optionIndex) {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Container(
  //       color: MyColors.grey1,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Row(
  //           children: [
  //             SizedBox(
  //               width: 80,
  //               child: Text(
  //                 addProductCtr.options[optionIndex].color!,
  //                 style: MyTextStyles.f14.copyWith(color: MyColors.black2),
  //               ),
  //             ),
  //             Container(
  //               height: 20,
  //               child: VerticalDivider(
  //                 thickness: 1,
  //                 color: MyColors.subTitle,
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             SizedBox(
  //               width: 60,
  //               child: Center(
  //                 child: Text(
  //                   addProductCtr.options[optionIndex].size!,
  //                   style: MyTextStyles.f14.copyWith(color: MyColors.black2),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             Text(
  //               'Price'.tr,
  //               style: MyTextStyles.f14.copyWith(color: MyColors.black1),
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Container(
  //                 child: TextField(
  //                     controller: addProductCtr.optionsControllers[optionIndex],
  //                     keyboardType: TextInputType.number,
  //                     decoration: InputDecoration(
  //                         fillColor: MyColors.white,
  //                         filled: true,
  //                         focusedBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.white),
  //                         ),
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.white),
  //                         ),
  //                         contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0))),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
