class DiscussGroup {
  int id; // 组id
  int postId; // 关联的post ID
  String cover; // 封面
  String title; // 讨论组标题 默认就是post的title
  String lastestMsg; // 最新的消息
  int time;
  int unread;

  DiscussGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    cover = json['cover'];
    title = json['title'];
    lastestMsg = json['lastestMsg'];
    time = json['time'];
    unread = json['unread'];
  }
}
