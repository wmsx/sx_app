class Menger {
  int id;
  String username;
  String email;
  String avatar;
  String chatToken;

  Menger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    chatToken = json['chatToken'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['id'] = id;
    json['username'] = username;
    json['email'] = email;
    json['avatar'] = avatar;
    json['chatToken'] = chatToken;
    return json;
  }
}
