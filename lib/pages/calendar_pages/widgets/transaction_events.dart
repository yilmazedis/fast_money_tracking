import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/methods.dart';
import '../../../models/item.dart';
import '../../../utils/constants.dart';
import '../../../utils/getx_storage.dart';
import '../../report_page/report_page.dart';

class TransactionEvents extends StatelessWidget {

  final List<Item> transactions;

  const TransactionEvents({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {

    Color colorCategory;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          colorCategory =
          transactions[index].type == ItemType.income ? Colors.lightGreen : AppColor.red;
          return GestureDetector(
            onTap: () {
              Get.to(() => ReportPage(items: [transactions[index]]));
            },
            child: Column(
              children: [
                Container(
                  color: AppColor.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          categoryItems[transactions[index].category].data,
                          color: colorCategory,
                        ),
                        SizedBox(
                          width: 150,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 15, right: 10),
                            child: Text(
                                getTranslated(
                                    context, categoryItems[transactions[index].category].text),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Expanded(
                          child: Text('(${transactions[index].description})',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic),
                              overflow: TextOverflow.fade),
                        ),
                        //this widget will never overflow
                        Flexible(
                          flex: 0,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(right: 10, left: 7),
                            child: Text(
                                '${format(transactions[index].amount)} $currency',
                                style: GoogleFonts.aBeeZee(
                                  fontSize:
                                  format(transactions[index].amount)
                                      .length >
                                      15
                                      ? 16
                                      : 17,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15.5,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 0.25,
                  indent: 20,
                  color: AppColor.grey,
                ),
              ],
            ),
          );
        });
  }
}