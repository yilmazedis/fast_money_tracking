import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../localization/methods.dart';
import '../../../utils/constants.dart';
import '../../../widgets/classes/drop_down_box.dart';

class ShowDate extends StatelessWidget {
  final RxString selectedDate;
  const ShowDate({super.key, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 25,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 27,
              color: Color.fromRGBO(82, 179, 252, 1),
            ),
            const SizedBox(
              width: 10,
            ),
            Obx(() => DateDisplay(selectedDate.value)),
            const Spacer(),
            DropDownBox(selectedDate: selectedDate)
          ],
        ));
  }
}

class DateDisplay extends StatelessWidget {
  final String selectedDate;
  DateDisplay(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat(dateFormat).format(todayDT);
    String since = getTranslated(context, 'Since');
    TextStyle style =
    GoogleFonts.aBeeZee(fontSize: 20, fontWeight: FontWeight.bold);

    Map<String, Widget> dateMap = {
      'Today': Text('$today', style: style),
      'This week': Text(
        '$since ${DateFormat(dateFormat).format(startOfThisWeek)}',
        style: style,
      ),
      'This month': Text(
          '$since ${DateFormat(dateFormat).format(startOfThisMonth)}',
          style: style),
      'This quarter': Text(
        '$since ${DateFormat(dateFormat).format(startOfThisQuarter)}',
        style: style,
      ),
      'This year': Text(
        '$since ${DateFormat(dateFormat).format(startOfThisYear)}',
        style: style,
      ),
      'All': Text(getTranslated(context, 'All'), style: style)
    };
    var dateListKey = dateMap.keys.toList();
    var dateListValue = dateMap.values.toList();

    for (int i = 0; i < dateListKey.length; i++) {
      if (selectedDate == dateListKey[i]) {
        return dateListValue[i];
      }
    }
    return Container();
  }
}