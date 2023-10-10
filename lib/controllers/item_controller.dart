import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  final RxList<Item> _items = RxList<Item>();

  RxList<Item> get items => _items;

  void add(Item item) {
    _items.add(item);
  }

  void addAll(List<Item> items) {
    _items.clear();
    _items.addAll(items);
  }

  void clear() {
    _items.clear();
  }

  int get length {
    return _items.length;
  }
}