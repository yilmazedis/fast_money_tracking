import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';
import '../classes/category_item.dart';
import '../classes/toast.dart';

class CategoryCard extends StatelessWidget {
  final Color mainColor;
  final Rx<int> index;

  const CategoryCard({super.key, required this.mainColor, required this.index});

  @override
  Widget build(BuildContext context) {

    return Obx(() => GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          index.value = await showIcons(context, mainColor, index.value);
        },
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 21),
            child: Row(
              children: [
                Icon(
                  categoryItems[index.value].data,
                  size: 40,
                  color: mainColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 31),
                    child: Text(
                      getTranslated(context, categoryItems[index.value].text),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.25,
            color: AppColor.grey,
            indent: 85,
          ),
        ])));
  }
}
