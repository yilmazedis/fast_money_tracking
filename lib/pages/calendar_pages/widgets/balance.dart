import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/methods.dart';
import '../../../utils/constants.dart';
import '../../../utils/getx_storage.dart';

class Balance extends StatelessWidget {
  final List? items;

  const Balance({this.items, super.key});

  @override
  Widget build(BuildContext context) {
    double income = 0, expense = 0, balance = 0;
    if (items != null) {
      for (int i = 0; i < items!.length; i++) {
        if (items![i].type == ItemType.income) {
          income = income + items![i].amount;
        } else {
          expense = expense + items![i].amount;
        }
        balance = income - expense;
      }
    }
    Widget summaryFrame(String type, double amount, color) => Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // this widget will never overflow
        Text(
          getTranslated(context, type),
          style: TextStyle(
              color: color,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        Text('${format(amount.toDouble())} $currency',
            style: GoogleFonts.aBeeZee(
                color: color,
                fontSize: (format(amount.toDouble()).length > 19)
                    ? 11.5
                    : format(amount.toDouble()).length > 14
                    ? 14
                    : 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis)
      ],
    );
    return Container(
      color: Colors.white54,
      height: 69,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            summaryFrame(
              'INCOME',
              income,
              Colors.lightGreen,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: summaryFrame('EXPENSE', expense, red)),
            Flexible(
                child: summaryFrame('TOTAL BALANCE', balance, Colors.black)),
          ],
        ),
      ),
    );
  }
}
