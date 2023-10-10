import 'package:get_storage/get_storage.dart';

void setData(String key, dynamic value) => GetStorage().write(key, value);

void removeKey(String key) => GetStorage().remove(key);

int? getInt(String key) => GetStorage().read(key);

String? getString(String key) => GetStorage().read(key);

bool? getBool(String key) => GetStorage().read(key);

double? getDouble(String key) => GetStorage().read(key);

dynamic getData(String key) => GetStorage().read(key);

void clearData() async => GetStorage().erase();

String currency = "TL";