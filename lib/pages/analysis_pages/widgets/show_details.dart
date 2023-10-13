import 'package:fast_money_tracking/pages/analysis_pages/widgets/show_money_frame.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/item.dart';
import '../../../utils/constants.dart';
import 'generate_category_details.dart';

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
    return Column(
      children: [
        ShowMoneyFrame(type, typeValue, balance),
        const SizedBox(height: 20,),
        GenerateCategoryDetails(itemGroup: itemGroup, type: type.toLowerCase(),)
      ],
    );
  }
}