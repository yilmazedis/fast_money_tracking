import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/classes/app_bar.dart';
import 'add_edit_page.dart';

class AddInput extends StatelessWidget {

  final _formKey1 = GlobalKey<FormState>(debugLabel: '_formKey1'),
      _formKey2 = GlobalKey<FormState>(debugLabel: '_formKey2');

  AddInput({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.blue1,
          appBar: const InExAppBar(isInputPage: true,),
          body: TabBarView(
            children: [
              AddEditPage(
                type: 'Income',
                formKey: _formKey1,
                item: null,
                isEdit: false,
              ),
              AddEditPage(
                type: 'Expense',
                formKey: _formKey2,
                item: null,
                isEdit: false,
              ),
            ],
          ),
        ));
  }
}