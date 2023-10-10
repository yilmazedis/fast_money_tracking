import 'package:fast_money_tracking/utils/getx_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';
import 'app_traits.dart';

class DropDownBox extends StatelessWidget {
  final RxString selectedDate;

  const DropDownBox({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shadows: const [BoxShadow()],
        color: blue2,
        shape: appShapeBorder(radius: 15),
      ),
      child: SizedBox(
        height: 35,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: Obx(() =>  DropdownButton<String>(
              dropdownColor: blue2,
              value: selectedDate.value,
              elevation: 10,
              icon: const Icon(
                Icons.arrow_drop_down_outlined,
                size: 28,
              ),
              onChanged: (value) {
                setData(AppStorageKey.selectedDate, value.toString());
                selectedDate(value);
              },
              items: timeline.map((time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(
                    getTranslated(context, time)!,
                    style: const TextStyle(
                      fontSize: 18.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            )),
          ),
        ),
      ),
    );
  }
}