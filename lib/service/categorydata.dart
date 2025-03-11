import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ui_new/model/categoryModel.dart';

class CatergoryDataJson {
  Future<List<Categorymodel>> getCategory() async {
    String jsonString = await rootBundle.loadString(
      'assets/json/category.json',
    );
    // print(jsonDecode(jsonString));
    return List<Categorymodel>.from(
      jsonDecode(jsonString).map((cat) => Categorymodel.fromJson(cat)),
    );
  }
}
