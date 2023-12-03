class Category {
  int categoryId;
  String categoryName;
  String createdAt;
  String categoryImage;
  String updatedAt;
  String? deletedAt;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryImage,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['CategoryID'],
      categoryName: json['CategoryName'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      categoryImage: json['CategoryImage'],
    );
  }
  //to Json
  Map<String, dynamic> toJson() => {
        "CategoryID": categoryId,
        "CategoryName": categoryName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "CategoryImage": categoryImage,
      };
}
