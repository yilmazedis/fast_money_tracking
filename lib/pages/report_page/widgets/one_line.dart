import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/methods.dart';
import '../../../utils/constants.dart';

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
