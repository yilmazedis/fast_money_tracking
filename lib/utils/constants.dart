import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/classes/category_item.dart';

Color green = const Color.fromRGBO(57, 157, 3, 1),
    red = const Color.fromRGBO(217, 89, 89, 1),
    white = const Color.fromRGBO(255, 255, 255, 1),
    blue1 = const Color.fromRGBO(210, 234, 251, 1),
    blue2 = const Color.fromRGBO(139, 205, 254, 1),
    blue3 = const Color.fromRGBO(89, 176, 222, 1),
    blue4 = const Color.fromRGBO(82, 179, 252, 1),
    grey = Colors.grey;

class AppColors {
  static final Color color60 = Color(0xFFFFFFFF);
  static final Color color30 = Color(0xFF912676);
  static final Color color10 = Color(0xFF016CFF);
}

class AppStorageKey {
  static const String selectedDate = "selectedDate";
}

List<CategoryItem> categoryItems = [
  CategoryItem(data: Icons.fastfood, text: "Fast Food"),
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
  'All': DateTime(2000), // You can set this to null or another default value as needed
};

String dateFormat = 'dd/MM/yyyy';

String format(double number) =>
    NumberFormat("#,###,###,###,###,###.##", "en_US").format(number);

