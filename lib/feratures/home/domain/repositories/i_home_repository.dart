import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../entities/disease_entity.dart';
import '../entities/news_entity.dart';
import '../entities/region_entity.dart';
import '../entities/shrimp_price_entity.dart';

abstract class IHomeRepository {
  Future<Either<AppFailure, DataWithMeta<List<RegionEntity>>>> getRegions(String keyword);
  Future<Either<AppFailure, DataWithMeta<List<ShrimpPriceEntity>>>> getShrimpPrices(
      {int? page, int? perPage, int? regionId});
  Future<Either<AppFailure, DataWithMeta<List<NewsEntity>>>> getNews({int? page, int? perPage});
  Future<Either<AppFailure, DataWithMeta<List<DiseaseEntity>>>> getDiseases({int? page, int? perPage});
}
