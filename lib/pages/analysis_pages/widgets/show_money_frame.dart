import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/methods.dart';
import '../../../utils/constants.dart';
import '../../../utils/getx_storage.dart';

class ShowMoneyFrame extends StatelessWidget {
  final String type;
  final double typeValue, balance;
  const ShowMoneyFrame(this.type, this.typeValue, this.balance, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget rowFrame(String typeName, double value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(context, typeName),
            style: const TextStyle(fontSize: 22),
          ),
          Expanded(
            child: Text(
              '${format(value)} $currency',
              style: GoogleFonts.aBeeZee(
                  fontSize: format(value.toDouble()).length > 22
                      ? 16.5
                      : format(value.toDouble()).length > 17
                      ? 19.5
                      : 22),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: AppColor.white2,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: AppColor.grey,
            width: 0.4,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18.5),
        child: Column(
          children: [
            rowFrame(type, typeValue),
            const SizedBox(
              height: 12.5,
            ),
            rowFrame(getTranslated(context, 'Balance'), balance)
          ],
        ),
      ),
    );
  }
}