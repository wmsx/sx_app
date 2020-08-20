class PostItem {
  int type;
  String url;

  static PostItem fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    PostItem postItem = PostItem();
    // postItem.type = map['type'];
    postItem.type = 2;
    postItem.url = map['url'];
    return postItem;
  }
}
