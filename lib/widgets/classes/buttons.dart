import 'package:flutter/material.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';

class SaveButton extends StatelessWidget {
  final void Function()? action;
  const SaveButton({required this.action, super.key});

  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          foregroundColor: white,
          backgroundColor: const Color.fromRGBO(236, 158, 66, 1),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          disabledForegroundColor: grey.withOpacity(0.38),
          disabledBackgroundColor: grey.withOpacity(0.12),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        label: Text(
          getTranslated(context, 'Save')!,
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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: action,
        style: ElevatedButton.styleFrom(
            foregroundColor: red,
            backgroundColor: white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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