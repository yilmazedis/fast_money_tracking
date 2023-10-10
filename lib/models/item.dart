import 'dart:ui';

class Item {
  int id;
  String type;
  double amount;
  String category;
  String description;
  String date;
  String time;
  Color? color;

  Item(
      {required this.id,
      required this.type,
      required this.amount,
      required this.category,
      required this.description,
      required this.date,
      required this.time
      });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date,
      'time': time
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
      time: map['time'],
    );
  }
}

Map<String, double> calculateFinalMoneyResult(List<Item> items, DateTime startDate, DateTime endDate) {
  double incomeSum = 0.0;
  double expenseSum = 0.0;
  double balance = 0.0;

  for (var item in items) {
    DateTime itemDate = DateTime.parse(item.date); // Assuming 'date' is a valid date string in your Item class
    if (itemDate.isAfter(startDate) && itemDate.isBefore(endDate)) {
      if (item.type == "income") {
        incomeSum += item.amount;
      } else if (item.type == "expense") {
        expenseSum -= item.amount; // Expenses are represented as negative values
      }
      balance += item.amount;
    }
  }

  return {
    "income": incomeSum,
    "expense": expenseSum,
    "balance": balance
  };
}

// double calculateSum(List<Item> items, DateTime startDate, DateTime endDate) {
//   double sum = 0.0;
//   for (var item in items) {
//     DateTime itemDate = DateTime.parse(item.date); // Assuming 'date' is a valid date string in your Item class
//     if (itemDate.isAfter(startDate) && itemDate.isBefore(endDate)) {
//       sum += item.amount;
//     }
//   }
//   return sum;
// }