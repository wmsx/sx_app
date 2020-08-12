import 'package:sx_app/config/net/sx_api.dart';
import 'package:sx_app/model/category.dart';
import 'package:sx_app/model/post.dart';

class SXRepository {
  static Future<List<Category>> fetchCategories() async {
    var response = await http.get('category/list');
    return response.data
        .map<Category>((item) => Category.fromJson(item))
        .toList();
  }

  static Future<List<Post>> fetchPosts(int categoryId, int lastId) async {
    var response = await http.get('post/list');
    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }
}
