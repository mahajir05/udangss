import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../entities/shrimp_price_entity.dart';
import '../repositories/i_home_repository.dart';

class GetShrimpPricesUc {
  final IHomeRepository repository;

  GetShrimpPricesUc({required this.repository});

  Future<Either<AppFailure, DataWithMeta<List<ShrimpPriceEntity>>>> call({
    int? perPage,
    int? page,
    int? regionId,
  }) =>
      repository.getShrimpPrices(
        perPage: perPage,
        page: page,
        regionId: regionId,
      );
}
