class DiscussGroup {
  int id; // 组id
  int postId; // 关联的post ID
  String cover; // 封面
  String name; // 讨论组标题 默认就是post的title
  String lastestMsg; // 最新的消息
  int time;
  int unread;

  DiscussGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    cover = json['cover'];
    name = json['name'];
    lastestMsg = json['lastestMsg'];
    lastestMsg = 'xxxxx';
    time = json['time'];
    time = 1234456;
    unread = json['unread'];
    unread = 1121321;
  }
}
