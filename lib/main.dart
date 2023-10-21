import 'package:fast_money_tracking/controllers/item_controller.dart';
import 'package:fast_money_tracking/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'localization/app_localization.dart';
import 'managers/sqflite_services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final itemController = Get.put(ItemController());

  DB.init().then((_) {
    DB.inputModelList().then((items) {
      final ItemController controller = Get.find();
      controller.addAll(items);
      runApp(const MyApp());
    });
  });
  //generateAndAddItems(itemController, 40);
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
      //home: const HomePage(title: 'Fast Money Tracking'),
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
      home: const HomePage(),
    );
  }
}