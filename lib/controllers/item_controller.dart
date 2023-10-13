import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  final _items = Rx<List<Item>>([]);

  Rx<List<Item>> get items => _items;

  void add(Item item) {
    _items.value.add(item);
    _items.refresh();
  }

  void addAll(List<Item> items) {
    _items.value.addAll(items);
    _items.refresh();
  }

  void edit(Item item) {
    final index = _items.value.indexWhere((existingItem) => existingItem.id == item.id);
    if (index != -1) {
      _items.value[index] = item;
      _items.refresh();
    }
  }

  void deleteById(String id) {
    _items.value.removeWhere((item) => item.id == id);
    _items.refresh();
  }

  void clear() {
    _items.value.clear();
    _items.refresh();
  }

  int get length {
    return _items.value.length;
  }
}