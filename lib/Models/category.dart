class Category {
  String? id;
  String? catImg;
  String? catName;

  Category({this.id, this.catImg, this.catName});

  toMap() {
    return {"catImg": catImg, "catName": catName};
  }

  Category.fromMap(Map<String, dynamic> map) {
    catImg = map['catImg'] ?? ' ';
    catName = map['catName'] ?? ' ';
    id = map['id'] ?? ' ';
  }
}
