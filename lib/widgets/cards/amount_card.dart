import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';

class AmountCard extends StatelessWidget {
  final TextEditingController controller;
  final Color mainColor;
  const AmountCard({super.key, required this.controller, required this.mainColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.white,
          border: Border(
              bottom: BorderSide(
                color: AppColor.grey,
                width: 0.6,
              ))),
      child: Padding(
        padding:
        const EdgeInsets.only(top: 15, bottom: 30, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              getTranslated(context, 'Amount'),
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            TextFormField(
              controller: controller,
              showCursor: true,
              maxLines: null,
              minLines: 1,
              cursorColor: mainColor,
              keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(decimal: true, signed: true)
                    : TextInputType.number,
                inputFormatters: [NumberWithDecimalFormatter()],
              style: GoogleFonts.aBeeZee(
                  color: mainColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: GoogleFonts.aBeeZee(
                    color: mainColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.currency_lira,
                    size: 45,
                    color: mainColor,
                  ),
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 24,
                    ),
                    onPressed: () {
                      controller.clear();
                    })
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberWithDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any characters that are not digits or a decimal point
    final cleanText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    return TextEditingValue(
      text: cleanText,
      selection: TextSelection.collapsed(offset: cleanText.length),
    );
  }
}
