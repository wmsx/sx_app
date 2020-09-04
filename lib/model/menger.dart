class Menger {
  int id;
  String name;
  String avatar;
  String chatToken;

  Menger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    chatToken = json['chatToken'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['id'] = id;
    json['name'] = name;
    json['avatar'] = avatar;
    json['chatToken'] = chatToken;
    return json;
  }
}
