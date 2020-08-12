class Menger {
  int id;
  String name;
  String email;
  String avatar;

  static Menger fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Menger menger = Menger();
    menger.id = map['id'];
    menger.name = map['name'];
    menger.email = map['email'];
    menger.avatar = map['avatar'];
    return menger;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    return map;
  }
}
