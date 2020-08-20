class Category {
  int id;
  String name;
  String showName;

  static Category fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Category category = Category();
    category.id = map['id'];
    category.name = map['name'];
    category.showName = map['showName'];
    return category;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['showName'] = showName;
    return data;
  }
}
