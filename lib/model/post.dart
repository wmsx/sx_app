import 'package:sx_app/model/post_item.dart';

import 'menger.dart';

class Post {
  int id;
  int type;
  int viewCount;
  String title;
  Menger menger;
  List<PostItem> items;
  int createAt;

  static Post fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Post post = Post();
    post.id = map['id'];
    post.type = map['type'];
    post.title = map['title'];
    post.viewCount = map['viewCount'];
    post.menger = Menger.fromJson(map['menger']);
    post.items = List()
      ..addAll((map['items'] as List ?? []).map((e) => PostItem.fromJson(e)));
    post.createAt = map['createAt'];
    return post;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'menger': menger,
        'items': items,
        'createAt': createAt,
      };
}
