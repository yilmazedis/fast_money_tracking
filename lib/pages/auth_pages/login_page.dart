import 'package:fast_money_tracking/managers/firestore_controller.dart';
import 'package:fast_money_tracking/pages/home_page.dart';
import 'package:fast_money_tracking/utils/getx_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../utils/constants.dart';
import '../../widgets/classes/app_traits.dart';
import '../../widgets/classes/buttons.dart';
import '../../widgets/classes/toast.dart';

class LoginPage extends StatelessWidget {

  final idController = TextEditingController(text: "sYCVXPW3aWVBopTNC9NI").obs;
  final passwordController = TextEditingController(text: "asdasd123").obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(
                height: 100,
              ),

              // Lottie.asset('assets/animations/going_car.json'),

              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    color: AppColor.color30,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    // Email and Passwords
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15),
                      child: TextField(
                        autocorrect: false,
                        controller: idController.value,
                        decoration: textFieldDecoration(
                            "User Id", "-x0A*_123!'^+%|Ω≈ß∑", Icons.security),
                      ),
                    )),
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15),
                      child: TextField(
                        controller: passwordController.value,
                        decoration:
                        textFieldDecoration("Password", "*********", Icons.key),
                        obscureText: true,
                        obscuringCharacter: "*",
                      ),
                    )),

                    appButton(title: "Login", onPressed: () {
                      FirestoreController.instance.getUser(idController.value.text).then((user) {
                        if (passwordController.value.text == user.password) {
                          User.setUser(user).then((value) {
                            Get.offAll(() => const HomePage());
                          });
                        } else {
                          showSnackbar("Hata!", "Giriş bilgileri yanlış!", SnackbarType.warning);
                        }
                      });
                    }, backgroundColor: AppColor.color60, textColor: AppColor.color30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
