import 'package:dartz/dartz.dart';

import '../../../../cores/errors/app_failure.dart';
import '../../../../cores/errors/exceptions/api_exception.dart';
import '../../../../cores/models/data_with_meta.dart';
import '../../../../cores/utils/app_util.dart';
import '../../domain/entities/disease_entity.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/entities/region_entity.dart';
import '../../domain/entities/shrimp_price_entity.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../data_sources/interfaces/i_home_remote_data_source.dart';

class HomeRepository implements IHomeRepository {
  final IHomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, DataWithMeta<List<RegionEntity>>>> getRegions(String keyword) async {
    try {
      final result = await remoteDataSource.getRegions(keyword);
      return Right(DataWithMeta<List<RegionEntity>>(result.data ?? [], result.meta ?? {}));
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
      appPrint("[$this][getRegions][catch] error: $e");
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AppFailure, DataWithMeta<List<ShrimpPriceEntity>>>> getShrimpPrices(
      {int? page, int? perPage, int? regionId}) async {
    try {
      final result = await remoteDataSource.getShrimpPrices(page: page, perPage: perPage, regionId: regionId);
      return Right(DataWithMeta<List<ShrimpPriceEntity>>(result.data ?? [], result.meta ?? {}));
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
      appPrint("[$this][getShrimpPrices][catch] error: $e");
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AppFailure, DataWithMeta<List<NewsEntity>>>> getNews({int? page, int? perPage}) async {
    try {
      final result = await remoteDataSource.getNews(page: page, perPage: perPage);
      return Right(DataWithMeta<List<NewsEntity>>(result.data ?? [], result.meta ?? {}));
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
      appPrint("[$this][getNews][catch] error: $e");
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AppFailure, DataWithMeta<List<DiseaseEntity>>>> getDiseases({int? page, int? perPage}) async {
    try {
      final result = await remoteDataSource.getDiseases(page: page, perPage: perPage);
      return Right(DataWithMeta<List<DiseaseEntity>>(result.data ?? [], result.meta ?? {}));
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
      appPrint("[$this][getDiseases][catch] error: $e");
      return Left(UnknownFailure());
    }
  }
}
