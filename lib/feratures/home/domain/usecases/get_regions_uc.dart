import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../entities/region_entity.dart';
import '../repositories/i_home_repository.dart';

class GetRegionsUc {
  final IHomeRepository repository;

  GetRegionsUc({required this.repository});

  Future<Either<AppFailure, DataWithMeta<List<RegionEntity>>>> call(String keyword) => repository.getRegions(keyword);
}
