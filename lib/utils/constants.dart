import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/classes/category_item.dart';

class AppColor {
  static const color60 = Color(0xFFFFFFFF);
  static const color30 = Color(0xFF912676);
  static const color10 = Color(0xFF016CFF);
  static const green = Color.fromRGBO(57, 157, 3, 1);
  static const red = Color.fromRGBO(217, 89, 89, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const white2 = Color.fromRGBO(239, 247, 253, 1);
  static const blue1 = Color.fromRGBO(210, 234, 251, 1);
  static const blue2 = Color.fromRGBO(139, 205, 254, 1);
  static const blue3 = Color.fromRGBO(89, 176, 222, 1);
  static const blue4 = Color.fromRGBO(82, 179, 252, 1);
  static const blue5 = Color.fromRGBO(67, 125, 229, 1);
  static const orange = Color.fromRGBO(236, 158, 66, 1);
  static const orange2 = Color.fromRGBO(255, 168, 68, 1);
  static const grey = Colors.grey;
}

class AppStorageKey {
  static const selectedDate = "selectedDate";
}

class ItemType {
  static const income = "income";
  static const expense = "expense";
  static const balance = "balance";
}

List<CategoryItem> categoryItems = [
  CategoryItem(data: Icons.fastfood, text: "Food & Beverages"),
  CategoryItem(data: Icons.shopping_cart, text: "Shopping"),
  CategoryItem(data: Icons.home, text: "Home"),
  CategoryItem(data: Icons.local_gas_station, text: "Gas"),
  CategoryItem(data: Icons.school, text: "Education"),
  CategoryItem(data: Icons.local_hospital, text: "Health"),
  CategoryItem(data: Icons.sports_soccer, text: "Sports"),
  CategoryItem(data: Icons.airplane_ticket, text: "Travel"),
  CategoryItem(data: Icons.music_note, text: "Music"),
  CategoryItem(data: Icons.local_movies, text: "Movies"),
];

final DateTime now = DateTime.now(),
    todayDT = DateTime(now.year, now.month, now.day),
    startOfThisWeek = todayDT.subtract(Duration(days: todayDT.weekday - 1)),
    startOfThisMonth = DateTime(todayDT.year, todayDT.month, 1),
    startOfThisYear = DateTime(todayDT.year, 1, 1),
    startOfThisQuarter = DateTime(todayDT.year, quarterStartMonth, 1);

final int thisQuarter = (todayDT.month + 2) ~/ 3,
    quarterStartMonth = 3 * thisQuarter - 2;

final List<String> timeline = [
  'Today',
  'This week',
  'This month',
  'This quarter',
  'This year',
  'All'
];

final Map<String, DateTime> timelineDates = {
  'Today': todayDT,
  'This week': startOfThisWeek,
  'This month': startOfThisMonth,
  'This quarter': startOfThisQuarter,
  'This year': startOfThisYear,
  'All': DateTime(2000),
};

String dateFormat = 'dd/MM/yyyy';

DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm");
DateFormat timeFormat = DateFormat("HH:mm");

String format(double number) =>
    NumberFormat("#,###,###,###,###,###.##", "en_US").format(number);

