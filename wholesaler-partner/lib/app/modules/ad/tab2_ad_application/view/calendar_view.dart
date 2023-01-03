// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wholesaler_partner/app/modules/ad/tab2_ad_application/controller/tab2_ad_application_controller.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/utils/utils.dart';

class mCalendarView extends GetView {
  Tab2AdApplicationController ctr = Get.put(Tab2AdApplicationController());
  mCalendarView();

  late DateTime target_month_start_date;

  @override
  Widget build(BuildContext context) {
    target_month_start_date = Utils.toDateDash(
        date: ctr.tab2AdApplyModel.value.target_month_start_date!);

    return SfCalendar(
      onTap: (calendarTapDetails)
      { print(calendarTapDetails.date);
        ctr.calendarCellTapped(calendarTapDetails);},
      minDate: DateTime(
          target_month_start_date.year, target_month_start_date.month, 1),
      maxDate: DateTime(
          target_month_start_date.year, target_month_start_date.month+ 1, 0),
      initialDisplayDate: target_month_start_date,
      headerHeight: 0,
      viewHeaderHeight: 0,
      // monthViewSettings: MonthViewSettings(showTrailingAndLeadingDates: false),
      onViewChanged: (viewChangedDetails) {
        var a = viewChangedDetails.visibleDates.toList();
        ctr.Month.value = "${a[10].month.toString()} 월";
      },
      showCurrentTimeIndicator: false,
      headerStyle: CalendarHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: MyTextStyles.f18.copyWith(color: MyColors.black3),
      ),
      monthCellBuilder: (buildContext, monthCellDetails) {
        Color borderColor = MyColors.grey6;
        Color textColor = MyColors.black3;
        Color backgroundColor = Colors.white;
        // If not current month remove border and grey date text
        if (monthCellDetails.date.month != target_month_start_date.month) {
          borderColor = Colors.transparent;
          textColor = MyColors.grey2;
        }

        Widget childWidget = Text(
          monthCellDetails.date.day.toString(),
          style: MyTextStyles.f14.copyWith(color: textColor),
        );

        // If notApplicableDateTimes: grey background with X icon
        if (ctr.notApplicableDateTimes.contains(monthCellDetails.date)) {
          backgroundColor = MyColors.grey6;
          childWidget = Icon(
            Icons.close,
            color: MyColors.grey8,
            size: 32,
          );
        }

        return Obx(
          () => Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              // if selected date: orange background
              color: ctr.selectedDates.value.contains(monthCellDetails.date)
                  ? MyColors.orange1
                  : backgroundColor,
            ),
            // color: Colors.red,
            child: Center(child: childWidget),
          ),
        );
      },
      view: CalendarView.month,
    );
  }

  // _monthCellBuilder(BuildContext buildContext, MonthCellDetails monthCellDetails) {
  //   Color borderColor = MyColors.grey6;
  //   Color textColor = MyColors.black3;
  //   Color backgroundColor = Colors.white;
  //   // If not current month remove border and grey date text
  //   if (monthCellDetails.date.month != target_month_start_date.month) {
  //     borderColor = Colors.transparent;
  //     textColor = MyColors.grey2;
  //   }

  //   Widget childWidget = Text(
  //     monthCellDetails.date.day.toString(),
  //     style: MyTextStyles.f14.copyWith(color: textColor),
  //   );

  //   // If notApplicableDateTimes: grey background with X icon
  //   if (ctr.notApplicableDateTimes.contains(monthCellDetails.date)) {
  //     backgroundColor = MyColors.grey6;
  //     childWidget = Icon(
  //       Icons.close,
  //       color: MyColors.grey8,
  //       size: 32,
  //     );
  //   }

  //   // if selected date: orange background
  //   print('ctr.selectedDates.value ${ctr.selectedDates.value}');
  //   if (ctr.selectedDates.value.contains(monthCellDetails.date)) {
  //     backgroundColor = MyColors.orange1;
  //   }

  //   return Container(
  //     margin: EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: borderColor),
  //       color: backgroundColor,
  //     ),
  //     // color: Colors.red,
  //     child: Center(child: childWidget),
  //   );
  // }

  // List<AdApplication> _getDataSource() {
  //   final List<AdApplication> meetings = <AdApplication>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime = DateTime(today.year, today.month + 1, today.day, 9, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(AdApplication('Conference', startTime, const Color(0xFF0F8644), false));
  //   return meetings;
  // }
}

// /// An object to set the appointment collection data source to calendar, which
// /// used to map the custom appointment data to the calendar appointment, and
// /// allows to add, remove or reset the appointment collection.
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<AdApplication> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).selectedDate;
//   }

//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }

//   AdApplication _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final AdApplication meetingData;
//     if (meeting is AdApplication) {
//       meetingData = meeting;
//     }

//     return meetingData;
//   }
// }

// // / Custom business object class which contains properties to hold the detailed
// // / information about the event data which will be rendered in calendar.
// class AdApplication {
//   /// Creates a meeting class with required details.
//   AdApplication(this.eventName, this.selectedDate, this.background, this.isAllDay);

//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;

//   /// From which is equivalent to start time property of [Appointment].
//   DateTime selectedDate;

//   /// Background which is equivalent to color property of [Appointment].
//   Color background;

//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
