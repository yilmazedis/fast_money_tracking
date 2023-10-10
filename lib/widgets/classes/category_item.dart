

import 'package:flutter/cupertino.dart';

class CategoryItem {
  IconData data;
  String text;
  CategoryItem({required this.data, required this.text});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(data: json['data'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'iconCodePoint': data,
      'text': text,
    };
  }
}