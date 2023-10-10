import 'package:fast_money_tracking/utils/extensions/date_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/choose_date.dart';

class DateCard extends StatelessWidget {
  final Rx<DateTime> dateTime;
  final Rx<TimeOfDay> time;

  const DateCard({super.key, required this.dateTime, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 20, right: 20, top: 17.5, bottom: 19),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              chooseDate(context, dateTime);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Icon(
                    Icons.event,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                Obx(() => Text(
                  dateTime.value.dateFormat(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 21.5,
                  ),
                )),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
              chooseTime(context, time);
            },
            child: Obx( () => Text(
              time.value.timeFormat(),
              style: GoogleFonts.aBeeZee(
                fontSize: 21.5,
              ),
            )),
          )
        ],
      ),
    );
  }
}