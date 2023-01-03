import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/src/date_picker/date_picker_manager.dart';

class RangeDatePickerController extends GetxController {
  // Rx<String> firstDate = '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}'.obs;
  // Rx<String> endDate = '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}'.obs;
  // Rx<DateTime> startDate = DateTime.now().obs;
  // Rx<DateTime> endDate = DateTime.now().obs;

  /// [tempStartDate] and [tempEndDate] temporary dates used to save changed date, before the user clicks on the ok or cancel button.
  late DateTime tempStartDate;
  late DateTime tempEndDate;

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    tempStartDate = args.value.startDate ?? tempStartDate;
    tempEndDate = args.value.endDate ?? tempEndDate;
  }

  @override
  void onInit() {
    DateTime now = DateTime.now();
    tempStartDate = DateTime(now.year, now.month - 1, now.day);
    tempEndDate = now;
  }
}
