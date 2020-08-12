import 'package:sx_app/model/category.dart';

class MockSXRepository {
  static Future<List<Category>> fetchCategories() async {
    List<Category> categories = List();
    categories
      ..add(Category.fromMap({'id': 1, 'name': "编程与开发"}))
      ..add(Category.fromMap({'id': 2, 'name': "英语"}))
      ..add(Category.fromMap({'id': 3, 'name': "日语"}))
      ..add(Category.fromMap({'id': 4, 'name': "音乐"}))
      ..add(Category.fromMap({'id': 5, 'name': "绘画"}));

    return Future.value(categories);
  }
}
