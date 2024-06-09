import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../entities/news_entity.dart';
import '../repositories/i_home_repository.dart';

class GetNewsUc {
  final IHomeRepository repository;

  GetNewsUc({required this.repository});

  Future<Either<AppFailure, DataWithMeta<List<NewsEntity>>>> call({int? page, int? perPage}) => repository.getNews(
        page: page,
        perPage: perPage,
      );
}
