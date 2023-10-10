import 'dart:ffi';

import 'package:fast_money_tracking/widgets/classes/toast.dart';
import 'package:flutter/cupertino.dart';
import '../../localization/methods.dart';

void saveInputFunc(BuildContext context, bool saveFunction, String amount, String description) {
  if (amount.isEmpty) {
    toast(context, "Miktarı boş bırakamazsınız!");
    return;
  }

  // model.amount = amount.isEmpty
  //     ? 0
  //     : double.parse(description.replaceAll(',', ''));
  // model.description = description;
  if (saveFunction) {
    //DB.insert(model);
    //_amountController.clear();
    if (description.isNotEmpty) {
      // _DescriptionCardState.descriptionController.clear();
      Navigator.pop(context);
    }
    toast(context, 'Data has been saved');
  } else {
    // DB.update(model);
    Navigator.pop(context);
    toast(context, getTranslated(context, 'Transaction has been updated') ?? 'Transaction has been updated');
  }
}

Future<void> deleteInputFunction(BuildContext context) async {
  // void onDeletion() {
  //   DB.delete(model.id!);
  //   Navigator.pop(context);
  //   toast(context, 'Transaction has been deleted');
  // }
  //
  // Platform.isIOS
  //     ? await iosDialog(
  //         context,
  //         'Are you sure you want to delete this transaction?',
  //         'Delete',
  //         onDeletion)
  //     : await androidDialog(
  //         context,
  //         'Are you sure you want to delete this transaction?',
  //         'Delete',
  //         onDeletion);
}
