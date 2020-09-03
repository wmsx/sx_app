import 'package:flutter/material.dart';
import 'package:sx_app/config/net/sx_api.dart';
import 'package:sx_app/model/category.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/model/menger.dart';
import 'package:sx_app/model/post.dart';

abstract class Repository {
  Future<Menger> register(String loginName, String password);
  Future<Menger> login(String loginName, String password);
  Future<List<Category>> fetchCategories();
  Future<List<DiscussGroup>> fetchDiscussGroup();
  Future<List<Post>> fetchPosts(int categoryId, int lastId);
  Future<List<Post>> fetchThumbUpPost(int pageNum);
  Future<List<Post>> fetchFavoritePost(int pageNum);
  Future<List<Post>> fetchDashboardPost(int pageNum);
}

class SXRepository extends Repository {
  Future<Menger> register(String loginName, String password) async {
    var response = await http.post('menger/register', data: {
      'username': loginName,
      'password': password,
    });
    return Menger.fromJson(response.data);
  }

  Future<Menger> login(loginName, password) async {
    var response = await http.post('menger/login', data: {
      'username': loginName,
      'password': password,
    });
    return Menger.fromJson(response.data);
  }

  Future<List<Category>> fetchCategories() async {
    var response = await http.post('post/category/list');
    return response.data
        .map<Category>((item) => Category.fromJson(item))
        .toList();
  }

  Future<List<DiscussGroup>> fetchDiscussGroup() async {
    var response = await http.post('discuss/group/list');
    return response.data
        .map<DiscussGroup>((item) => DiscussGroup.fromJson(item))
        .toList();
  }

  Future<List<Post>> fetchPosts(int categoryId, int lastId) async {
    var response = await http.post('post/list',
        data: {"category_id": categoryId, "last_id": lastId});

    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }

  @override
  Future<List<Post>> fetchFavoritePost(int pn) async {
    var response = await http.post('post/favorite/list', data: {"pn": pn});
    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }

  @override
  Future<List<Post>> fetchThumbUpPost(int pn) async {
    var response = await http.post('post/favorite/list', data: {"pn": pn});
    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }

  @override
  Future<List<Post>> fetchDashboardPost(int pn) async {
    var response = await http.post('post/favorite/list', data: {"pn": pn});
    return response.data.map<Post>((item) => Post.fromJson(item)).toList();
  }
}
