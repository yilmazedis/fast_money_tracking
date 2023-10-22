import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/user.dart';

class UserController extends GetxController {
  final Rx<User> _user = Rx<User>(User.defaultUser());

  Rx<User> get user => _user;

  set(User user) => _user.value = user;
}