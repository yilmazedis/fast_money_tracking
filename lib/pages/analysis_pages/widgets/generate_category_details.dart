import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/item.dart';
import '../../report_page/report_page.dart';
import '../../../localization/methods.dart';
import '../../../utils/constants.dart';
import '../../../utils/getx_storage.dart';

class GenerateCategoryDetails extends StatelessWidget {

  final Map<int, List<Item>> itemGroup;
  final String type;

  const GenerateCategoryDetails({required this.itemGroup, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
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

    final mainColor = type == ItemType.income ? AppColor.green: AppColor.red;

    return Card(
        color: AppColor.white,
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
                color: mainColor,
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
                  style: GoogleFonts.aBeeZee(fontSize: 20, color: mainColor),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: mainColor,
              ),
            ],
          ),
        ));
  }
}