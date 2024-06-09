import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import '../services/secure_storage_service.dart';

import 'languages_di.dart' as language;
import '../../feratures/home/presentation/di/home_di.dart' as home;
import '../../feratures/shrimp_price/presentation/di/shrimp_price_di.dart' as shrimpprice;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => ApiService(
        dio: sl(),
        tokenDio: sl(),
        secureStorageService: sl(),
      ));
  sl.registerFactory(() => SecureStorageService());

  await Future.wait([
    language.init(),
    home.init(),
    shrimpprice.init(),
  ]);
}
