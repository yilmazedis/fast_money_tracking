import 'package:fast_money_tracking/pages/add_edit_pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/item_controller.dart';
import '../../localization/methods.dart';
import '../../managers/sqflite_services.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../utils/getx_storage.dart';
import '../../widgets/classes/app_bar.dart';

class ReportPage extends StatelessWidget {
  final List<Item> items;

  ReportPage({required this.items, Key? key}) : super(key: key);
  final ItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue1,
      appBar: BasicAppBar(title: getTranslated(context, 'Report')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];
                return GestureDetector(
                    onTap: () {
                      Get.to(() => EditPage(item: item))?.then((result) {
                        if (result == null) {
                          return;
                        }

                        if (result['item'] != null) {
                          controller.edit(result['item']);
                          DB.update(result['item']);
                        } else {
                          print("Deleted Item");
                          DB.delete(item.id);
                          controller.deleteById(item.id);
                        }
                        Get.back();
                      });
                    },
                    child: ItemDetails(item: item));
              },
            ),
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

class OneLine extends StatelessWidget {
  final IconData iconData;
  final String type;
  final String iconText;
  final String text;

  const OneLine(
      {super.key,
      required this.iconData,
      required this.type,
      required this.iconText,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        iconData,
        color: type == ItemType.income ? AppColor.green : AppColor.red,
        size: 23,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Text(
            getTranslated(context, iconText),
            style: const TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      Flexible(
        flex: 0,
        child: Text(
          getTranslated(context, text),
          style: GoogleFonts.aBeeZee(fontSize: 20),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.end,
        ),
      ),
    ]);
  }
}
