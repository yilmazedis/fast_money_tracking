import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/item_controller.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../widgets/cards/amount_card.dart';
import '../../widgets/cards/category_card.dart';
import '../../widgets/cards/date_card.dart';
import '../../widgets/cards/description_card.dart';
import '../../widgets/classes/buttons.dart';

class AddEditPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Item? inputModel;
  final String type;
  final IconData? categoryIcon;

  final ItemController controller = Get.find();
  final amountTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  Rx<int> categoryItemIndex = 0.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  AddEditPage({super.key,
    required this.formKey,
    required this.inputModel,
    required this.type,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    Color mainColor = type == 'Income' ? green : red;
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
          child: inputModel != null
              ? SaveAndDeleteButton(
            saveAndDeleteInput: true,
            formKey: formKey,
          )
              : const SaveButton(true, null, true),
        )
      ]),
    );
  }
}
