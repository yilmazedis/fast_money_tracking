import 'package:fast_money_tracking/utils/extensions/date_ext.dart';
import 'package:fast_money_tracking/utils/extensions/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../widgets/cards/amount_card.dart';
import '../../widgets/cards/category_card.dart';
import '../../widgets/cards/date_card.dart';
import '../../widgets/cards/description_card.dart';
import '../../widgets/classes/buttons.dart';

class AddEditPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  String type;
  String id = EnhancedString.uuid();
  final amountTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  Rx<int> categoryItemIndex = 0.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  final bool isEdit;

  AddEditPage({super.key,
    required this.formKey,
    required Item? item,
    required this.type,
    required this.isEdit
  }){
    initItem(item);
  }

  initItem(Item? item) {
    if (item != null) {

      id = item.id;
      type = item.type;
      amountTextController.text = item.amount.toString();
      categoryItemIndex.value = item.category;
      descriptionTextController.text = item.description;
      dateTime.value = dateTimeFormat.parse(item.date);
    }
  }

  void saveAction() {
    Item item = Item(id: id,
        type: type.toLowerCase(),
        amount: double.tryParse(amountTextController.text) ?? 0,
        category: categoryItemIndex.value,
        description: descriptionTextController.text,
        date: dateTime.value.addTimeOfDay(timeOfDay: selectedTime.value)
            .dateFormatWithTime());

    Get.back(result: {
      'item': item,
    });
  }

  void deleteAction() {
    Get.back(result: {
      'item': null,
    });
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = type.toLowerCase() == ItemType.income ? green : red;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(children: [
        AmountCard(controller: amountTextController, mainColor: mainColor,),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
              color: white,
              border: Border.all(
                color: grey,
                width: 0.6,
              )),
          child: Column(
            children: [
              CategoryCard(mainColor: mainColor, index: categoryItemIndex),
              DescriptionCard(controller: descriptionTextController,),
              DateCard(dateTime: dateTime, time: selectedTime),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: isEdit ?
          SaveAndDeleteButton(saveAction: saveAction, deleteAction: deleteAction,) :
          SaveButton(action: saveAction,),
        )
      ]),
    );
  }
}
