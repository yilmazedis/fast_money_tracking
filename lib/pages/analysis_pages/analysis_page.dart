import 'package:fast_money_tracking/pages/analysis_pages/widgets/show_date.dart';
import 'package:fast_money_tracking/pages/analysis_pages/widgets/show_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/item_controller.dart';
import '../../managers/sqflite_services.dart';
import '../../utils/constants.dart';
import '../../utils/getx_storage.dart';
import '../../widgets/classes/app_bar.dart';
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
          backgroundColor: AppColor.blue1,
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
                  DB.insert(result['item']);
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