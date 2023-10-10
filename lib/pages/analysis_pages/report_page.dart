import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../localization/methods.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../utils/getx_storage.dart';
import '../../widgets/classes/app_bar.dart';

class ReportPage extends StatelessWidget {
  final List<Item> items;
  const ReportPage({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue1,
      appBar: BasicAppBar(title: getTranslated(context, 'Report')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: List.generate(
            items.length,
                (index) {
              final item = items[index];
              return ItemDetails(item: item);
            },
          ),
        ),
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  final Item item;
  const ItemDetails({required this.item, super.key});
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
                categoryItems[item.category].data,
                color:item.type == 'Income'
                    ? green
                    : red,
                size: 23,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    categoryItems[item.category].text,
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
                  '${format(item.amount)} $currency',
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ));
  }
}