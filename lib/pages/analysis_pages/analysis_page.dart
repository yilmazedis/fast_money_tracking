import 'package:fast_money_tracking/pages/analysis_pages/report_page.dart';
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
import '../../widgets/classes/drop_down_box.dart';
import '../add_edit_pages/add_page.dart';

class AnalysisPage extends StatelessWidget {
  AnalysisPage({super.key});

  final dateStr = (getString(AppStorageKey.selectedDate) ?? "Today").obs;
  final ItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    ListView listViewChild(String type) {
      // Type From
      final RxString rxType = type.obs;
      return ListView(
        children: [
          ShowDate(selectedDate: dateStr),
          Obx(() => ShowDetails(type: rxType.value, selectedDate: dateStr.value, items: controller.items.value,)),
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
              Get.to(() => AddInput(), arguments: {"state": "Add", "index": -1})
                  ?.then((result) {
                if (result != null && result['item'] != null) {
                  controller.add(result['item']);
                }
              });
            },
            tooltip: 'Add',
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
  const ShowMoneyFrame(this.type, this.typeValue, this.balance, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget rowFrame(String typeName, double value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(context, typeName),
            style: const TextStyle(fontSize: 22),
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
            rowFrame(getTranslated(context, 'Balance'), balance)
          ],
        ),
      ),
    );
  }
}

class ShowDetails extends StatelessWidget {
  final String type;
  final String selectedDate;
  final List<Item> items;

  const ShowDetails({required this.type, required this.selectedDate, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = timelineDates[selectedDate] ?? DateTime(2000);

    final filteredItems = getItemsBetweenDates(items, dateTime, DateTime.now());
    Map<String, double> todaySums = calculateFinalMoneyResult(filteredItems);

    final typeValue = todaySums[type.toLowerCase()] ?? 0;
    final balance = todaySums[ItemType.balance] ?? 0;

    final itemGroup = groupItemsByCategoryAndType(type.toLowerCase(), filteredItems);
    print(filteredItems.length);
    print(itemGroup.length);
    return Column(
      children: [
        ShowMoneyFrame(type, typeValue, balance),
        const SizedBox(height: 20,),
        GenerateCategoryDetails(itemGroup: itemGroup, type: type.toLowerCase(),)
      ],
    );
  }
}

class GenerateCategoryDetails extends StatelessWidget {

  final Map<int, List<Item>> itemGroup;
  final String type;

  const GenerateCategoryDetails({required this.itemGroup, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    print(type);
    return Column(
        children: List.generate(itemGroup.keys.length, (index) {
          final items = itemGroup.values.elementAt(index);

          final totalAmount = calculateTotalAmount(items);

          return GestureDetector (
            onTap: () {
              Get.to(() => ReportPage(items: items));
            },
            child: CategoryDetails(type: type,
                category: itemGroup.keys.elementAt(index),
                amount: totalAmount),
          );
        },
        )
    );
  }
}

class CategoryDetails extends StatelessWidget {
  final String type;
  final int category;
  final double amount;
  const CategoryDetails({required this.type, required this.category, required this.amount, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
        color: white,
        elevation: 3,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                categoryItems[category].data,
                color : type == ItemType.income
                    ? green
                    : red,
                size: 23,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    getTranslated(context, categoryItems[category].text),
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              // attention: This widget will never overflow
              Flexible(
                flex: 0,
                child: Text(
                  '${format(amount)} $currency',
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ));
  }
}