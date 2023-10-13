import 'package:fast_money_tracking/pages/add_edit_pages/edit_page.dart';
import 'package:fast_money_tracking/pages/report_page/widgets/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/item_controller.dart';
import '../../localization/methods.dart';
import '../../managers/sqflite_services.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
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