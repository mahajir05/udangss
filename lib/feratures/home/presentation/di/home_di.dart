import '../../../../cores/depedency_injections/depedency_injection.dart';
import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/data_sources/interfaces/i_home_remote_data_source.dart';
import '../../data/repositories/home_repository.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../../domain/usecases/get_diseases_uc.dart';
import '../../domain/usecases/get_news_uc.dart';
import '../../domain/usecases/get_regions_uc.dart';
import '../../domain/usecases/get_shrimp_prices_uc.dart';
import '../blocs/disease/disease_bloc.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/regions/regions_bloc.dart';
import '../blocs/shrimp_price/shrimp_price_bloc.dart';
import '../cubits/cubit/shrimp_news_cubit.dart';
import '../cubits/filter/filter_cubit.dart';
import '../cubits/shrimp_disease/shrimp_disease_cubit.dart';
import '../cubits/shrimp_prices/shrimp_prices_cubit.dart';

Future<void> init() async {
  //! data sources
  sl.registerFactory<IHomeRemoteDataSource>(() => HomeRemoteDataSource(apiService: sl()));

  //! repositories
  sl.registerFactory<IHomeRepository>(() => HomeRepository(
        remoteDataSource: sl(),
      ));

  //! usecases
  sl.registerFactory(() => GetShrimpPricesUc(repository: sl()));
  sl.registerFactory(() => GetRegionsUc(repository: sl()));
  sl.registerFactory(() => GetNewsUc(repository: sl()));
  sl.registerFactory(() => GetDiseasesUc(repository: sl()));

  //! bloc
  sl.registerFactory(() => ShrimpPriceBloc(getShrimpPriceUc: sl()));
  sl.registerFactory(() => RegionsBloc(getRegionsUc: sl()));
  sl.registerFactory(() => NewsBloc(getNewsUc: sl()));
  sl.registerFactory(() => DiseaseBloc(getDiseasesUc: sl()));

  //! cubit
  sl.registerFactory(() => ShrimpPricesCubit());
  sl.registerFactory(() => FilterCubit());
  sl.registerFactory(() => ShrimpNewsCubit());
  sl.registerFactory(() => ShrimpDiseaseCubit());
}
