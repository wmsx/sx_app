class Category {
  int id;
  String name;

  static Category fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Category category = Category();
    category.id = map['id'];
    category.name = map['name'];
    return category;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
