import '../../domain/entities/disease_entity.dart';

class DiseaseModel extends DiseaseEntity {
  const DiseaseModel({
    super.id,
    super.image,
    super.fullName,
    super.metaDescription,
    super.createdAt,
    super.updatedAt,
  });

  static DiseaseModel fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      image: json['image'],
      fullName: json['full_name'],
      metaDescription: json['meta_description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['full_name'] = fullName;
    data['meta_description'] = metaDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
