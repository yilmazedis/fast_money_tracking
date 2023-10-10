import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controllers/item_controller.dart';
import '../../localization/methods.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../utils/getx_storage.dart';
import '../../widgets/classes/app_bar.dart';
import '../../widgets/classes/category_item.dart';
import '../../widgets/classes/drop_down_box.dart';
import '../add_edit_pages/add_page.dart';

class AnalysisPage extends StatelessWidget {
  AnalysisPage({super.key});

  final dateStr = (getString(AppStorageKey.selectedDate) ?? "Today").obs;

  Widget build(BuildContext context) {
    ListView listViewChild(String type) {
      return ListView(
        children: [
          ShowDate(selectedDate: dateStr),
          ShowDetails(RxString(type), dateStr),
        ],
      );
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          backgroundColor: blue1,
          appBar: const InExAppBar(
            isInputPage: false,
          ),
          body: TabBarView(
            children: [listViewChild('Expense'), listViewChild('Income')],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddInput(),
                  arguments: {"state": "Add", "index": -1})?.then((result) {
                // print("Result is " + result[0]["status"]);
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )),
    );
  }
}

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

class ShowMoneyFrame extends StatelessWidget {
  final String type;
  final double typeValue, balance;
  const ShowMoneyFrame(this.type, this.typeValue, this.balance);

  @override
  Widget build(BuildContext context) {
    Widget rowFrame(String typeName, double value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(context, typeName),
            style: TextStyle(fontSize: 22),
          ),
          Expanded(
            child: Text(
              '${format(value)} $currency',
              style: GoogleFonts.aBeeZee(
                  fontSize: format(value.toDouble()).length > 22
                      ? 16.5
                      : format(value.toDouble()).length > 17
                      ? 19.5
                      : 22),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 247, 253, 1),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: grey,
            width: 0.4,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18.5),
        child: Column(
          children: [
            rowFrame(type, typeValue),
            const SizedBox(
              height: 12.5,
            ),
            rowFrame('Balance', balance)
          ],
        ),
      ),
    );
  }
}

class ShowDetails extends StatelessWidget {

  final RxString type;
  final RxString selectedDate;
  ShowDetails(this.type, this.selectedDate);

  final ItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final dateTime = timelineDates[type] ?? DateTime(2000);
    Map<String, double> todaySums = calculateFinalMoneyResult(controller.items, dateTime, DateTime.now());

    final typeValue = todaySums[type.toLowerCase()] ?? 0;
    final balance = todaySums["balance"] ?? 0;

    return Obx(() => ShowMoneyFrame(type.value, typeValue, balance));
  }
}
