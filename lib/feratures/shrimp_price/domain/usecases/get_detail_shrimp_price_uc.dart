import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../entities/shrimp_price_entity.dart';
import '../repositories/i_shrimp_price_repository.dart';

class GetDetailShrimpPriceUc {
  final IShrimpPriceRepository repository;

  GetDetailShrimpPriceUc({required this.repository});

  Future<Either<AppFailure, ShrimpPriceEntity>> call({required int id, int? regionId}) =>
      repository.getDetails(id, regionId);
}
