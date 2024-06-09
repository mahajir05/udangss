import 'package:equatable/equatable.dart';

class DiseaseEntity extends Equatable {
  final int? id;
  final String? image;
  final String? fullName;
  final String? metaDescription;
  final String? createdAt;
  final String? updatedAt;

  const DiseaseEntity({this.id, this.image, this.fullName, this.metaDescription, this.createdAt, this.updatedAt});

  @override
  List<Object?> get props => [id, image, fullName, metaDescription, createdAt, updatedAt];
}
