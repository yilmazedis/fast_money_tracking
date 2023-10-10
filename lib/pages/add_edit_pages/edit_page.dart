import 'package:flutter/material.dart';

import '../../localization/methods.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../widgets/classes/app_bar.dart';
import 'add_edit_page.dart';

class EditPage extends StatelessWidget {
  static final _formKey3 = GlobalKey<FormState>(debugLabel: '_formKey3');
  final Item inputModel;
  final IconData categoryIcon;
  const EditPage({super.key,
    required this.inputModel,
    required this.categoryIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue1,
      appBar: BasicAppBar(title: getTranslated(context, 'Edit')),
      body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: AddEditPage(
            formKey: _formKey3,
            inputModel: inputModel,
            categoryIcon: categoryIcon,
            type: inputModel.type,
          )
      ),
    );
  }
}
