import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/errors/exceptions/api_exception.dart';
import '../../../../cores/utils/app_util.dart';
import '../../domain/entities/shrimp_price_entity.dart';
import '../../domain/repositories/i_shrimp_price_repository.dart';
import '../data_sources/interfaces/i_shrimp_price_remote_data_source.dart';

class ShrimpPriceRepository implements IShrimpPriceRepository {
  final IShrimpPriceRemoteDataSource remoteDataSource;

  ShrimpPriceRepository({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, ShrimpPriceEntity>> getDetails(int id, int? regionId) async {
    try {
      final result = await remoteDataSource.getDetails(id, regionId);
      return Right(result.data!);
    } on SessionException {
      return Left(SessionFailure());
    } on ClientException catch (e) {
      return Left(ClientFailure(
        code: e.code,
        messages: e.toString(),
        errors: e.errors,
      ));
    } on ServerException {
      return const Left(ServerFailure());
    } on UnknownException {
      return Left(UnknownFailure());
    } catch (e) {
      appPrint("[$this][getDetails][catch] error: $e");
      return Left(UnknownFailure());
    }
  }
}
