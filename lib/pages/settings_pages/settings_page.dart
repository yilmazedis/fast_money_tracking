

import 'package:fast_money_tracking/pages/auth_pages/login_page.dart';
import 'package:fast_money_tracking/pages/settings_pages/select_language_page.dart';
import 'package:fast_money_tracking/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../localization/methods.dart';
import '../../models/user.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          color: AppColor.blue3,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          height: 200,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orangeAccent,
                  child: CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColor.blue1,
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 71,
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '${getTranslated(context, 'Hi you')}!',
                  style: const TextStyle(fontSize: 30),
                ),
                // Spacer(),
                // Icon(
                //   Icons.notifications_rounded,
                //   size: 25.sp,
                // )
              ],
            ),
          ),
        ),
      ),
      body: Settings(),
    );
  }
}


class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<Function> pageRoute = [
      () {
      Get.to(() => SelectLanguagePage());
      },

      () {
        User.removeUser().then((value) {
          print("Logout - has user ${User.hasUser()}");
          Get.offAll(() => LoginPage());
        });
      }
    ];

    List<Widget> settingsIcons = [
      const Icon(
        Icons.language,
        size: 32,
        color: Colors.lightBlue,
      ),
      const Icon(
        Icons.logout,
        size: 32,
        color: AppColor.red,
      )
    ];

    List<String> settingsList = [
      getTranslated(context, 'Language'),
      getTranslated(context, 'Sign out'),
    ];

    return ListView.builder(
        itemCount: settingsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              pageRoute[index]();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: SizedBox(
                    child: Center(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              settingsList[index],
                              style: const TextStyle(fontSize: 18.5),
                            ),
                          ),
                          leading: CircleAvatar(
                              radius: 24,
                              backgroundColor: const Color.fromRGBO(229, 231, 234, 1),
                              child: settingsIcons[index]),
                          trailing:
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.blueGrey,
                          ),
                        )),
                  ),
                ),
                const Divider(
                  indent: 78,
                  height: 0.1,
                  thickness: 0.4,
                  color: AppColor.grey,
                ),
              ],
            ),
          );
        });
  }
}