class Category {
  Category(
      {required this.category_name,
      required this.cover_photo,
      required this.description,
      required this.category_id});
  final String description;
  final String category_name;
  final CoverPhoto cover_photo;
  final String category_id;

  Category.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        category_name = json['category_name'],
        cover_photo = CoverPhoto.fromJson(json['cover_photo']),
        category_id = json['id'];
}

class CoverPhoto {
  CoverPhoto({required this.url});

  final String url;

  CoverPhoto.fromJson(Map<String, dynamic> json) : url = json['url'];
}
