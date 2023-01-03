import 'package:intl/intl.dart';

class Utils {
  static DateTime toDate({required String date}) {
    DateTime parseDate = DateFormat("yyyy.MM.dd").parse(date);
    return parseDate;
  }

  static DateTime toDateDash({required String date}) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    return parseDate;
  }

  static String dateToString({required DateTime date}) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return dateStr;
  }

  static String numberFormat({required int number, String? suffix}) {
    final formatCurrency = NumberFormat.decimalPattern();
    return number == 0 ? "0" + " " + (suffix ?? '') : formatCurrency.format(number) + " " + (suffix ?? '');
  }
}
