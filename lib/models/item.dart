import 'dart:math';
import 'package:fast_money_tracking/utils/extensions/string_ext.dart';
import 'package:intl/intl.dart';
import '../controllers/item_controller.dart';
import '../utils/constants.dart';

class Item {
  String id;
  String type;
  double amount;
  int category;
  String description;
  String date;

  Item(
      {required this.id,
      required this.type,
      required this.amount,
      required this.category,
      required this.description,
      required this.date
      });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date,
    };
    return map;
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: map['date'],
    );
  }
}

List<Item> getItemsBetweenDates(List<Item> items, DateTime startDate, DateTime endDate) {

  List<Item> newItems = [];
  DateFormat customFormat = DateFormat("dd-MM-yyyy HH:mm");

  for (var item in items) {
    DateTime itemDate = customFormat.parse(item.date); // Assuming 'date' is a valid date string in your Item class
    if (itemDate.isAfter(startDate) &&
        itemDate.isBefore(endDate.add(const Duration(days: 1)))) {
      newItems.add(item);
    }
  }

  return newItems;
}

Map<String, double> calculateFinalMoneyResult(List<Item> items) {
  double incomeSum = 0.0;
  double expenseSum = 0.0;
  double balance = 0.0;

  for (var item in items) {
    if (item.type == ItemType.income) {
      incomeSum += item.amount;
    } else if (item.type == ItemType.expense) {
      expenseSum -= item.amount;
    }
  }

  balance = (incomeSum + expenseSum).abs();

  return {
    ItemType.income: incomeSum,
    ItemType.expense: expenseSum,
    ItemType.balance: balance
  };
}

Map<int, List<Item>> groupItemsByCategoryAndType(String type, List<Item> items) {
  Map<int, List<Item>> groupedItems = {};
  for (var item in items) {
    if (type != item.type) { continue; }
    if (!groupedItems.containsKey(item.category)) {
      groupedItems[item.category] = [];
    }
    groupedItems[item.category]!.add(item);
  }

  return groupedItems;
}

double calculateTotalAmount(List<Item> items) {
  double totalAmount = 0;
  for (var item in items) {
    totalAmount += item.amount;
  }
  return totalAmount;
}
void generateAndAddItems(ItemController itemController, int itemCount) {
  List<Item> items = [];
  for (int i = 1; i <= itemCount; i++) {
    Item item = Item(
      id: EnhancedString.uuid(),
      type: i % 2 == 0 ? ItemType.income : ItemType.expense,
      amount: Random().nextDouble() * 100,
      category: Random().nextInt(9) + 1,
      description: "Item $i Description",
      date: "12-10-2023 11:11"
      //date: generateRandomDate()
    );
    items.add(item);
  }

  itemController.addAll(items);
}

String generateRandomDate() {
  int year = Random().nextInt(2) + 2021; // You can change the starting year as needed
  int month = Random().nextInt(11) + 1; // Random month between 1 and 8
  int day = Random().nextInt(29) + 1;   // Random day between 1 and 8

  // Ensure that month and day are formatted as two digits with leading zeros
  String formattedMonth = month < 10 ? "0$month" : "$month";
  String formattedDay = day < 10 ? "0$day" : "$day";

  String randomDate = "$formattedDay-$formattedMonth-$year 11:11";
  return randomDate;
}
