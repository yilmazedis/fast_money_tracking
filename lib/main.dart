import 'package:fast_money_tracking/controllers/item_controller.dart';
import 'package:fast_money_tracking/models/user.dart';
import 'package:fast_money_tracking/pages/auth_pages/login_page.dart';
import 'package:fast_money_tracking/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/user_controller.dart';
import 'localization/app_localization.dart';
import 'managers/firestore_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {

    Get.put(FirestoreController());
    Get.put(ItemController());
    Get.put(UserController());

    // FirestoreController.instance.itemListener(callback: (items) {
    //   print(items);
    //   itemController.addAll(items);
    //   runApp(const MyApp());
    // }, companyId: userController.user.value.companyId);

    // DB.init().then((_) {
    //   DB.inputModelList().then((items) {
    //     final ItemController controller = Get.find();
    //
    //     final UserController userController = Get.find();
    //     userController.user.value = User.getUser();
    //
    //     controller.addAll(items);
    //     runApp(const MyApp());
    //   });
    // });

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fast Money Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('tr', "TR"),
      supportedLocales: const [
        Locale("tr", "TR"),
        Locale("en", "US"),
        Locale("de", "DE"),
        Locale("es", "ES"),
        Locale("fr", "FR"),
        Locale("hi", "IN"),
        Locale("ja", "JP"),
        Locale("ko", "KR"),
        Locale("pt", "PT"),
        Locale("ru", "RU"),
        Locale("vi", "VN"),
        Locale("zh", "CN"),
      ],
      home: User.hasUser() ? const HomePage() : LoginPage(),
    );
  }
}