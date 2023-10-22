import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_money_tracking/controllers/user_controller.dart';
import 'package:fast_money_tracking/utils/getx_storage.dart';
import 'package:get/get.dart';

class User {
  late String id;
  late String name;
  late bool isEditor;
  late String password;
  late String companyId;

  User({required this.id,
      required this.name,
      required this.isEditor,
      required this.password,
      required this.companyId});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "isEditor": isEditor,
      "password": password,
      "companyId": companyId
    };
  }

  factory User.fromJson(Map<String, dynamic> json, String? id) => User(
        id: id ?? json["id"],
        name: json["name"],
        isEditor: json["isEditor"],
        password: json["password"],
        companyId: json["companyId"],
      );

  factory User.defaultUser() {
    return User(
      id: "default Id",
      name: "Default name",
      isEditor: false,
      password: "Default password",
      companyId: "Default companyId",
    );
  }

  static Future<void> setUser(User user) async {
    final UserController userController = Get.find();
    userController.user.value = user;
    await setData(_Key.userData, user.toJson());
  }

  static User getUser() {
    final userData = getData(_Key.userData);
    if (userData == null) {
      return User.defaultUser();
    }
    return userModelFromMap(userData, null);
  }

  static bool hasUser() {
    return hasData(_Key.userData);
  }

  static Future<void> removeUser() async {
    return await removeKey(_Key.userData);
  }
}

class _Key {
  static const userData = "userData";
}

User userModelFromMap(Map<String, dynamic> map, String? id) => User.fromJson(map, id);
User userModelFromJson(String str, String? id) => User.fromJson(json.decode(str), id);
String userModelToJson(User data) => json.encode(data.toJson());
