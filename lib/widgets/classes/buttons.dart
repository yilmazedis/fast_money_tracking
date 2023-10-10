import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';
import 'in_out_functions.dart';

class SaveButton extends StatefulWidget {
  final bool saveInput;
  final Function? saveCategoryFunc;
  final bool? saveFunction;
  const SaveButton(this.saveInput, this.saveCategoryFunc, this.saveFunction, {super.key});

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          if (widget.saveInput) {
            // saveInputFunc(context, widget.saveFunction!);
          } else {
            // widget.saveCategoryFunc!();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: white,
          backgroundColor: const Color.fromRGBO(236, 158, 66, 1),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          disabledForegroundColor: grey.withOpacity(0.38),
          disabledBackgroundColor: grey.withOpacity(0.12),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        label: Text(
          getTranslated(context, 'Save')!,
          style: TextStyle(fontSize: 25),
        ),
        icon: Icon(
          Icons.save,
          size: 25,
        ),
      ),
    );
  }
}

class SaveAndDeleteButton extends StatelessWidget {
  final bool saveAndDeleteInput;
  final Function? saveCategory;
  final String? parentExpenseItem, categoryName;
  final BuildContext? contextEx, contextExEdit, contextIn, contextInEdit;
  final GlobalKey<FormState>? formKey;
  const SaveAndDeleteButton({super.key,
    required this.saveAndDeleteInput,
    this.saveCategory,
    this.categoryName,
    this.parentExpenseItem,
    this.contextEx,
    this.contextExEdit,
    this.contextIn,
    this.contextInEdit,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              if (saveAndDeleteInput) {
                deleteInputFunction(
                  context,
                );
              } else {
                // deleteCategoryFunction(
                //   context: context,
                //   categoryName: this.categoryName!,
                //   parentExpenseItem: this.parentExpenseItem,
                //   contextEx: this.contextEx,
                //   contextExEdit: this.contextExEdit,
                //   contextIn: this.contextIn,
                //   contextInEdit: this.contextInEdit,
                // );
              }
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: red,
                backgroundColor: white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                disabledForegroundColor: grey.withOpacity(0.38),
                disabledBackgroundColor: grey.withOpacity(0.12),
                side: BorderSide(
                  color: red,
                  width: 2,
                ),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
            icon: Icon(
              Icons.delete,
              size: 25,
            ),
            label: Text(
              getTranslated(context, 'Delete')!,
              style: TextStyle(fontSize: 25),
            )),
        SaveButton(saveAndDeleteInput, saveCategory, false),
      ],
    );
  }
}

// Future<void> deleteCategoryFunction(
//     {required BuildContext context,
//       required String categoryName,
//       String? parentExpenseItem,
//       BuildContext? contextEx,
//       contextExEdit,
//       contextIn,
//       contextInEdit}) async {
//   void onDeletion() {
//     if (contextInEdit != null) {
//       List<CategoryItem> incomeItems = sharedPrefs.getItems('income items');
//       incomeItems.removeWhere((item) => item.text == categoryName);
//       sharedPrefs.saveItems('income items', incomeItems);
//       Provider.of<ChangeIncomeItemEdit>(contextInEdit, listen: false)
//           .getIncomeItems();
//       if (contextIn != null) {
//         Provider.of<ChangeIncomeItem>(contextIn, listen: false)
//             .getIncomeItems();
//       }
//     } else {
//       if (parentExpenseItem == null) {
//         sharedPrefs.removeItem(categoryName);
//         var parentExpenseItemNames = sharedPrefs.parentExpenseItemNames;
//         parentExpenseItemNames.removeWhere(
//                 (parentExpenseItemName) => categoryName == parentExpenseItemName);
//         sharedPrefs.parentExpenseItemNames = parentExpenseItemNames;
//       } else {
//         List<CategoryItem> expenseItems =
//         sharedPrefs.getItems(parentExpenseItem);
//         expenseItems.removeWhere((item) => item.text == categoryName);
//         sharedPrefs.saveItems(parentExpenseItem, expenseItems);
//       }
//       Provider.of<ChangeExpenseItem>(contextEx!, listen: false)
//           .getAllExpenseItems();
//       Provider.of<ChangeExpenseItemEdit>(contextExEdit!, listen: false)
//           .getAllExpenseItems();
//     }
//     Navigator.pop(context);
//     toast(context,'Category has been deleted');
//   }
//
//   Platform.isIOS
//       ? await iosDialog(
//       context,
//       'Are you sure you want to delete this category?', 'Delete',
//       onDeletion)
//       : await androidDialog(context,  'Are you sure you want to delete this category?', 'Delete',onDeletion);
// }
