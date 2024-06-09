import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../entities/shrimp_price_entity.dart';

abstract class IShrimpPriceRepository {
  Future<Either<AppFailure, ShrimpPriceEntity>> getDetails(int id, int? regionId);
}
