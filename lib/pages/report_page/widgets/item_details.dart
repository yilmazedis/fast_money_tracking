import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/methods.dart';
import '../../../models/item.dart';
import '../../../utils/constants.dart';
import '../../../utils/getx_storage.dart';
import 'one_line.dart';

class ItemDetails extends StatelessWidget {
  final Item item;

  const ItemDetails({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OneLine(
                iconData: categoryItems[item.category].data,
                type: item.type,
                iconText: categoryItems[item.category].text,
                text: '${format(item.amount)} $currency',
              ),
              OneLine(
                iconData: Icons.calendar_month,
                type: item.type,
                iconText: getTranslated(context, 'Date'),
                text: item.date,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                item.description,
                style: GoogleFonts.aBeeZee(fontSize: 15),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ));
  }
}