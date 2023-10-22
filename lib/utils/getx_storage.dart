import 'package:get_storage/get_storage.dart';

Future<void> setData(String key, dynamic value) async => await GetStorage().write(key, value);

Future<void> removeKey(String key) async => await GetStorage().remove(key);

int? getInt(String key) => GetStorage().read(key);

String? getString(String key) => GetStorage().read(key);

bool? getBool(String key) => GetStorage().read(key);

double? getDouble(String key) => GetStorage().read(key);

dynamic getData(String key) => GetStorage().read(key);

Future<void> clearData() async => await GetStorage().erase();

bool hasData(String key) => GetStorage().hasData(key);

String currency = "TL";