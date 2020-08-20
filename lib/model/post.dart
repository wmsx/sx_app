import 'package:sx_app/model/post_item.dart';

import 'menger.dart';

class Post {
  int id;
  int type;
  String title;
  Menger menger;
  List<PostItem> items;
  int onlookerCount;
  int createAt;

  static Post fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Post post = Post();
    post.id = map['id'];
    post.type = map['type'];
    post.title = map['title'];
    // post.onlookerCount = map['onlookerCount'];
    post.onlookerCount = 0;
    post.menger = Menger.fromJson(map['menger']);
    post.items = List()
      ..addAll((map['items'] as List ?? []).map((e) => PostItem.fromJson(e)));
    post.createAt = map['CreateAt'];
    return post;
  }
}
