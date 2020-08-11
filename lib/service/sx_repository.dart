import 'package:sx_app/config/net/sx_api.dart';
import 'package:sx_app/model/category.dart';

class SXRepository {
  static Future fetchCategories() async {
    var response = await http.get('category/list');
    return response.data
        .map<Category>((item) => Category.fromMap(item))
        .toList();
  }
}
