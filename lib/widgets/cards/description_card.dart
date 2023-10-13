import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../localization/methods.dart';
import '../../utils/constants.dart';

class DescriptionCard extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.5),
        child: TextFormField(
          controller: controller,
          maxLines: 4,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          keyboardAppearance: Brightness.light,
          maxLength: 200,
          cursorColor: AppColor.blue1,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: getTranslated(context, 'Description'),
              hintStyle: GoogleFonts.cousine(
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.clear();
                  })
                  : const SizedBox(),
              icon: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.description_outlined,
                  size: 40,
                  color: Colors.blueGrey,
                ),
              )),
        ),
      ),
      const Divider(
        height: 0,
        thickness: 0.25,
        color: AppColor.grey,
        indent: 85,
      )
    ]);
  }
}