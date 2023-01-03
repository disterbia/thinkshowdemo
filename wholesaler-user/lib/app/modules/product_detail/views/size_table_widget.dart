import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_user/app/Constants/enum.dart';
import 'package:wholesaler_user/app/models/product_sizes_model.dart';
import 'package:wholesaler_user/app/modules/product_detail/controller/product_detail_controller.dart';

class SizeTableWidget extends StatelessWidget {
  ProductDetailController ctr = Get.put(ProductDetailController());
  SizeTableWidget();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          width: 200,
          height: 100,
          child: CrossScroll(
            verticalBar: CrossScrollBar(thickness: 0),
            child: DataTable(
              columns: DataColumnBuilder(),
              rows: <DataRow>[
                ...ctr.product.value.sizes!.map(
                  (size) => DataRow(
                    cells: DataCellBuilder(size),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataColumnBuilder() {
    return <DataColumn>[
      DataColumn(
        label: Text('CM'),
      ),
      if (ctr.product.value.sizes![0].shoulderCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.shoulder_cross_length),
        ),
      if (ctr.product.value.sizes![0].chestCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.chest_cross_length),
        ),
      if (ctr.product.value.sizes![0].armhole != null)
        DataColumn(
          label: Text(ProductSizeType.armhole),
        ),
      if (ctr.product.value.sizes![0].armStraightLength != null)
        DataColumn(
          label: Text(ProductSizeType.arm_straight_length),
        ),
      if (ctr.product.value.sizes![0].armCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.arm_cross_length),
        ),
      if (ctr.product.value.sizes![0].sleeveCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.sleeve_cross_length),
        ),
      if (ctr.product.value.sizes![0].bottomCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.bottom_cross_length),
        ),
      if (ctr.product.value.sizes![0].strap != null)
        DataColumn(
          label: Text(ProductSizeType.strap),
        ),
      if (ctr.product.value.sizes![0].totalEntryLength != null)
        DataColumn(
          label: Text(ProductSizeType.total_entry_length),
        ),
      if (ctr.product.value.sizes![0].waistCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.waist_cross_length),
        ),
      if (ctr.product.value.sizes![0].hipCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.hip_cross_length),
        ),
      if (ctr.product.value.sizes![0].bottomTopCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.bottom_top_cross_length),
        ),
      if (ctr.product.value.sizes![0].thighCrossLength != null)
        DataColumn(
          label: Text(ProductSizeType.thigh_cross_length),
        ),
      if (ctr.product.value.sizes![0].open != null)
        DataColumn(
          label: Text(ProductSizeType.open),
        ),
      if (ctr.product.value.sizes![0].lining != null)
        DataColumn(
          label: Text(ProductSizeType.lining),
        ),
    ];
  }

  DataCellBuilder(ProductSizeModel size) {
    return <DataCell>[
      DataCell(
        Text('${size.size}'),
      ),
      if (size.shoulderCrossLength != null)
        DataCell(
          Text(size.shoulderCrossLength.toString()),
        ),
      if (size.chestCrossLength != null)
        DataCell(
          Text(size.chestCrossLength.toString()),
        ),
      if (size.armhole != null)
        DataCell(
          Text(size.armhole.toString()),
        ),
      if (size.armStraightLength != null)
        DataCell(
          Text(size.armStraightLength.toString()),
        ),
      if (size.armCrossLength != null)
        DataCell(
          Text(size.armCrossLength.toString()),
        ),
      if (size.sleeveCrossLength != null)
        DataCell(
          Text(size.sleeveCrossLength.toString()),
        ),
      if (size.bottomCrossLength != null)
        DataCell(
          Text(size.bottomCrossLength.toString()),
        ),
      if (size.strap != null)
        DataCell(
          Text(size.strap.toString()),
        ),
      if (size.totalEntryLength != null)
        DataCell(
          Text(size.totalEntryLength.toString()),
        ),
      if (size.waistCrossLength != null)
        DataCell(
          Text(size.waistCrossLength.toString()),
        ),
      if (size.hipCrossLength != null)
        DataCell(
          Text(size.hipCrossLength.toString()),
        ),
      if (size.bottomTopCrossLength != null)
        DataCell(
          Text(size.bottomTopCrossLength.toString()),
        ),
      if (size.thighCrossLength != null)
        DataCell(
          Text(size.thighCrossLength.toString()),
        ),
      if (size.open != null)
        DataCell(
          Text(size.open.toString()),
        ),
      if (size.lining != null)
        DataCell(
          Text(size.lining.toString()),
        ),
    ];
  }
}
