import 'package:flutter/material.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';
import 'dart:io' show Platform;

import 'alert_dialog.dart';

class SaveButton extends StatelessWidget {
  final void Function()? action;
  const SaveButton({required this.action, super.key});

  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.orange,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          disabledForegroundColor: AppColor.grey.withOpacity(0.38),
          disabledBackgroundColor: AppColor.grey.withOpacity(0.12),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        label: Text(
          getTranslated(context, 'Save'),
          style: const TextStyle(fontSize: 25),
        ),
        icon: const Icon(
          Icons.save,
          size: 25,
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final void Function()? action;
  const DeleteButton({required this.action, super.key});

  void deleteFunction(context, onDeletion) async {
    Platform.isIOS
        ? await iosDialog(
        context,
        'Are you sure you want to delete this category?', 'Delete',
        onDeletion)
        : await androidDialog(context,  'Are you sure you want to delete this category?', 'Delete', onDeletion);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async => deleteFunction(context, action),
        style: ElevatedButton.styleFrom(
            foregroundColor: AppColor.red,
            backgroundColor: AppColor.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            disabledForegroundColor: AppColor.grey.withOpacity(0.38),
            disabledBackgroundColor: AppColor.grey.withOpacity(0.12),
            side: const BorderSide(
              color: AppColor.red,
              width: 2,
            ),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
        icon: const Icon(
          Icons.delete,
          size: 25,
        ),
        label: Text(
          getTranslated(context, 'Delete'),
          style: const TextStyle(fontSize: 25),
        ));
  }
}

class SaveAndDeleteButton extends StatelessWidget {
  final void Function()? saveAction;
  final void Function()? deleteAction;
  const SaveAndDeleteButton({required this.saveAction, required this.deleteAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SaveButton(action: saveAction),
        DeleteButton(action: deleteAction)
      ],
    );
  }
}

Widget appButton({String? title = "", required void Function()? onPressed, required Color backgroundColor, required Color textColor}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: IntrinsicHeight(
      child: SizedBox.expand(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: backgroundColor,
            //padding: const EdgeInsets.symmetric(vertical: 20),
            //padding: EdgeInsets.only(
            //     left: 120, right: 120, top: 20, bottom: 20),
          ),
          child: Text(
            title!,
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    ),
  );
}