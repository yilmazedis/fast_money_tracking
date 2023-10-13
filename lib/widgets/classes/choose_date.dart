import 'package:fast_money_tracking/utils/constants.dart';
import 'package:fast_money_tracking/utils/extensions/date_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_traits.dart';

void chooseDate(BuildContext context, Rx<DateTime> dateTime) {
  showDatePicker(
    context: context,
    initialDate: dateTime.value,
    firstDate: DateTime(2000),
    lastDate: DateTime(DateTime.now().year + 100),
    initialEntryMode: DatePickerEntryMode.calendar,
    locale: const Locale("tr", "TR"),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(shape: appShapeBorder()),
          colorScheme: const ColorScheme.light(primary: AppColor.blue2),
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: AppColor.blue2,
              textStyle: GoogleFonts.aBeeZee(),
            ),
          ),
        ),
        child: child!,
      );
    },
  ).then((value) {
    if (value != null) {
      dateTime(value);
    }
  });
}

void chooseTime(BuildContext context, Rx<TimeOfDay> selectedTime) {
   showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context,
    initialTime: selectedTime.value,
  ).then((value) {
     if (value != null) {
       selectedTime(value);
     }
   });
}
