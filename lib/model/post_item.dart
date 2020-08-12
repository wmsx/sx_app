class PostItem {
  String url;

  static PostItem fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    PostItem postItem = PostItem();
    postItem.url = map['url'];
    return postItem;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['url'] = url;
    return map;
  }
}
