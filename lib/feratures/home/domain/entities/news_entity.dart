import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int? id;
  final String? image;
  final String? title;
  final String? body;
  final String? createdAt;
  final String? updatedAt;

  const NewsEntity({this.id, this.image, this.title, this.body, this.createdAt, this.updatedAt});

  @override
  List<Object?> get props => [id, image, title, body, createdAt, updatedAt];
}
