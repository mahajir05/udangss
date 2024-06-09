import '../../domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    super.id,
    super.image,
    super.title,
    super.body,
    super.createdAt,
    super.updatedAt,
  });

  static NewsModel fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
