import 'package:flutter/material.dart';

class ConstantByDii {
  Color vert() => Color.fromRGBO(0, 102, 51, 1);
  Color blanc() => Color.fromRGBO(255, 255, 255, 1);
  Color noir() => Color.fromRGBO(0, 0, 0, 1);
  Color gris() => Color.fromRGBO(229, 229, 229, 1);
  String getName(List<String> strLIst) {
    String str = '';
    for (var item in strLIst) {
      str = str + item[0].toUpperCase() + item.substring(1) + ' ';
    }
    return str;
  }
}
