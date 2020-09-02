class User {
  int id;
  String username;
  String email;
  String chatToken;
  String avarar;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    chatToken = json['chatToken'];
    avarar = json['avarar'];
  }
}
