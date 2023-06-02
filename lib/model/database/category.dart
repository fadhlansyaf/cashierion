class CategoryModel {
  final int id;
  final String name;
  final String description;

  CategoryModel({required this.name, required this.description, this.id = 0});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      name: json["name"] ?? '', description: json["description"] ?? '', id: json["product_category_id"] ?? 0);

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}
