import '../../../../cores/depedency_injections/depedency_injection.dart';
import '../../data/data_sources/interfaces/i_shrimp_price_remote_data_source.dart';
import '../../data/data_sources/shrimp_price_remote_data_source.dart';
import '../../data/repositories/shrimp_price_repository.dart';
import '../../domain/repositories/i_shrimp_price_repository.dart';
import '../../domain/usecases/get_detail_shrimp_price_uc.dart';
import '../blocs/detail_shrimp_price/detail_shrimp_price_bloc.dart';

Future<void> init() async {
  //! data sources
  sl.registerFactory<IShrimpPriceRemoteDataSource>(() => ShrimpPriceRemoteDataSource(apiService: sl()));

  //! repositories
  sl.registerFactory<IShrimpPriceRepository>(() => ShrimpPriceRepository(
        remoteDataSource: sl(),
      ));

  //! usecases
  sl.registerFactory(() => GetDetailShrimpPriceUc(repository: sl()));

  //! bloc
  sl.registerFactory(() => DetailShrimpPriceBloc(getDetailShrimpPriceUc: sl()));

  //! cubit
  // sl.registerFactory(() => ShrimpPricesCubit());
}
