import 'package:sx_app/model/category.dart';
import 'package:sx_app/model/post.dart';

class MockSXRepository {
  static Future<List<Category>> fetchCategories() async {
    List<Category> categories = List();
    categories
      ..add(Category.fromJson({'id': 1, 'name': "编程与开发"}))
      ..add(Category.fromJson({'id': 2, 'name': "英语"}))
      ..add(Category.fromJson({'id': 3, 'name': "日语"}))
      ..add(Category.fromJson({'id': 4, 'name': "音乐"}))
      ..add(Category.fromJson({'id': 5, 'name': "绘画"}));

    return Future.value(categories);
  }

  static Future<List<Post>> fetchPosts(int categoryId, int lastId) async {
    List<Post> posts = List();
    posts
      ..add(Post.fromJson({
        'id': 1,
        'type': 0,
        'title': 'title1',
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar': 'avatar1',
        },
        'items': [
          {
            'url': "url1",
          },
          {
            'url': "url2",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 1,
        'type': 0,
        'title': 'title2',
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar': 'avatar1',
        },
        'items': [
          {
            'url': "url1",
          },
          {
            'url': "url2",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 1,
        'type': 0,
        'title': 'title3',
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar': 'avatar1',
        },
        'items': [
          {
            'url': "url1",
          },
          {
            'url': "url2",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 1,
        'type': 0,
        'title': 'title4',
        'menger': {
          'id': 1,
          'name': 'name1',
          'email': 'email1',
          'avatar': 'avatar1',
        },
        'items': [
          {
            'url': "url1",
          },
          {
            'url': "url2",
          },
        ]
      }));
    return Future.value(posts);
  }
}
