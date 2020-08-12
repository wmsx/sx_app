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
            'url':
                "https://cdn.pixabay.com/photo/2020/07/22/08/39/waterfall-5428467_1280.jpg",
          },
          {
            'url':
                "https://cdn.pixabay.com/photo/2017/12/15/13/51/polynesia-3021072_1280.jpg",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 2,
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
            'url':
                "https://cdn.pixabay.com/photo/2020/06/10/09/25/anemone-5281964_1280.jpg",
          },
          {
            'url':
                "https://cdn.pixabay.com/photo/2015/05/28/05/03/portrait-787522_1280.jpg",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 3,
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
            'url':
                "https://cdn.pixabay.com/photo/2016/11/29/03/36/beautiful-1867093_1280.jpg",
          },
          {
            'url':
                "https://cdn.pixabay.com/photo/2016/05/03/16/10/morning-1369446_1280.jpg",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 4,
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
            'url':
                "https://cdn.pixabay.com/photo/2016/03/23/04/01/beautiful-1274056_1280.jpg",
          },
          {
            'url':
                "https://cdn.pixabay.com/photo/2019/06/02/17/27/summer-4246927_1280.jpg",
          },
        ]
      }))
      ..add(Post.fromJson({
        'id': 5,
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
            'url':
                "https://cdn.pixabay.com/photo/2018/04/03/20/26/woman-3287956_1280.jpg",
          },
          {
            'url':
                "https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/ee6a0cffae89456ead73ac89bd329862.jpg!sswm",
          },
        ]
      }));
    return Future.value(posts);
  }
}
