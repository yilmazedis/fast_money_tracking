
enum TransactionCategory {
  income,
  expense,
}

extension TransactionCategoryExtension on TransactionCategory {
  String get value {
    switch (this) {
      case TransactionCategory.income:
        return 'income';
      case TransactionCategory.expense:
        return 'expense';
    }
  }
}