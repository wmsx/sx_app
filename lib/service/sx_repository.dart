import 'package:flutter/material.dart';
import 'package:sx_app/config/net/sx_api.dart';
import 'package:sx_app/model/category.dart';
import 'package:sx_app/model/post.dart';

class SXRepository {
  static Future<List<Category>> fetchCategories() async {
    var response = await http.post('post/category/list');

    debugPrint('${response.data}');
    return response.data
        .map<Category>((item) => Category.fromJson(item))
        .toList();
  }

  static Future<List<Post>> fetchPosts(int categoryId, int lastId) async {
    var response = await http.post('post/list',
        data: {"category_id": categoryId, "last_id": lastId});

    debugPrint('${response.data}');
    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }
}
