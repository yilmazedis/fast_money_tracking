import 'package:flutter/material.dart';
import '../../localization/methods.dart';
import '../../utils/constants.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BasicAppBar({required this.title, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.blue3,
      title: Text(title, style: const TextStyle(fontSize: 21)),
    );
  }
}


class InExAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isInputPage;
  const InExAppBar({required this.isInputPage, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Tab appBarTab(String title) => Tab(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Align(
            child: Text(
              getTranslated(context, title),
              style: const TextStyle(fontSize: 19),
            )),
      ),
    );
    return AppBar(
      backgroundColor: AppColor.blue2,
      title: TabBar(
        unselectedLabelColor: AppColor.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColor.blue4,
        ),
        tabs: [
          appBarTab('EXPENSE'),
          appBarTab('INCOME')
        ],
      ),
    );
  }
}

class CalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? action;
  const CalendarAppBar({required this.action, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.blue3,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: TextButton(
            onPressed: action,
            child: Text(
              getTranslated(context, 'Today'),
              style: const TextStyle(fontSize: 18.5,  color: AppColor.white),
            ),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Calendar'),
          style: const TextStyle(fontSize: 21)),
    );
  }
}


class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget editCategory;
  const CategoryAppBar({required this.editCategory, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.blue3,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editCategory));
            },
            child: Row(children: [
              const Icon(
                Icons.edit,
                size: 19,
              ),
              const SizedBox(width: 3),
              Text(
                getTranslated(context, 'Edit'),
                style: const TextStyle(fontSize: 19),
              ),
            ]),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Category'),
          style: const TextStyle(fontSize: 21)),
    );
  }
}


class EditCategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget addCategory;
  const EditCategoryAppBar({required this.addCategory, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.blue3,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: TextButton(
            onPressed: () =>  Navigator.push(context,
                MaterialPageRoute(builder: (context) => addCategory)),
            child: Text(
              getTranslated(context, 'Add'),
              style: TextStyle(fontSize: 18.5,  color: AppColor.white),
            ),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Edit Category'),
          style: const TextStyle(fontSize: 21)),
    );
  }
}