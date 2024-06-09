import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../entities/disease_entity.dart';
import '../repositories/i_home_repository.dart';

class GetDiseasesUc {
  final IHomeRepository repository;

  GetDiseasesUc({required this.repository});

  Future<Either<AppFailure, DataWithMeta<List<DiseaseEntity>>>> call({int? page, int? perPage}) =>
      repository.getDiseases(
        page: page,
        perPage: perPage,
      );
}
