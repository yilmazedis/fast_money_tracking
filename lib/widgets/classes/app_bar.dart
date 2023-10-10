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
      backgroundColor: blue3,
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
              getTranslated(context, title)!,
              style: TextStyle(fontSize: 19),
            )),
      ),
    );
    return AppBar(
      backgroundColor: blue2,
      title: TabBar(
        unselectedLabelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: blue4,
        ),
        tabs: [
          appBarTab('EXPENSE'),
          appBarTab('INCOME')
        ],
      ),
      // actions: isInputPage ? [
      //   IconButton(
      //     icon: const Icon(Icons.check),
      //     iconSize: 28,
      //     onPressed: () {
      //       // saveInputFunc(context,true);
      //     },
      //   )
      // ] : null,
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
      backgroundColor: blue3,
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
              SizedBox(width: 3),
              Text(
                getTranslated(context, 'Edit'),
                style: TextStyle(fontSize: 19),
              ),
            ]),
          ),
          // child: Icon(Icons.edit),
        ),
      ],
      title: Text(getTranslated(context, 'Category')!,
          style: TextStyle(fontSize: 21)),
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
      backgroundColor: blue3,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: TextButton(
            onPressed: () =>  Navigator.push(context,
                MaterialPageRoute(builder: (context) => addCategory)),
            child: Text(
              getTranslated(context, 'Add'),
              style: TextStyle(fontSize: 18.5,  color: white),
            ),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Edit Category'),
          style: TextStyle(fontSize: 21)),
    );
  }
}