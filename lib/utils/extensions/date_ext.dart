import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension EnhancedDate on DateTime {
  // Formatter
  String dateFormat() => DateFormat("dd-MM-yyyy").format(this);

  String dateFormatWithTime() => DateFormat("dd-MM-yyyy HH:mm").format(this);

  DateTime addTimeOfDay({required TimeOfDay timeOfDay}) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}

extension EnhancedTimeOfDay on TimeOfDay {
  // Formatter
  String timeFormat() {
    final String period = this.period == DayPeriod.am ? 'AM' : 'PM';
    final String hour = hourOfPeriod.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}