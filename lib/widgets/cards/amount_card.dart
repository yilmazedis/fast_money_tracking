import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
          color: white,
          border: Border(
              bottom: BorderSide(
                color: grey,
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
                  padding: EdgeInsets.only(right: 5),
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