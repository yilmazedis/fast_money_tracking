import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../localization/methods.dart';
import '../../widgets/classes/app_bar.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: getTranslated(context, 'Select a language')),
      body: const Placeholder(),
    );
  }
}
