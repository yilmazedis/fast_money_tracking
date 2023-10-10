import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension EnhancedDate on DateTime {
  // Formatter
  String dateFormat() => DateFormat("dd/MM/yyyy").format(this);
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