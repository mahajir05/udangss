import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feratures/home/domain/entities/region_entity.dart';
import '../../feratures/home/presentation/blocs/disease/disease_bloc.dart';
import '../../feratures/home/presentation/blocs/news/news_bloc.dart';
import '../../feratures/home/presentation/blocs/regions/regions_bloc.dart';
import '../../feratures/home/presentation/blocs/shrimp_price/shrimp_price_bloc.dart';
import '../../feratures/home/presentation/cubits/cubit/shrimp_news_cubit.dart';
import '../../feratures/home/presentation/cubits/filter/filter_cubit.dart';
import '../../feratures/home/presentation/cubits/shrimp_disease/shrimp_disease_cubit.dart';
import '../../feratures/home/presentation/cubits/shrimp_prices/shrimp_prices_cubit.dart';
import '../../feratures/home/presentation/home_screen.dart';
import '../../feratures/shrimp_disease/presentation/shrimp_disease_screen.dart';
import '../../feratures/shrimp_news/presentation/shrimp_news_screen.dart';
import '../../feratures/shrimp_price/presentation/blocs/detail_shrimp_price/detail_shrimp_price_bloc.dart';
import '../../feratures/shrimp_price/presentation/shrimp_price_screen.dart';
import '../depedency_injections/depedency_injection.dart';
import 'app_route.dart';

class AppNavigation {
  static GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(String initialLocation) {
    return GoRouter(
      initialLocation: '/$initialLocation',
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          name: AppRoute.home,
          path: '/${AppRoute.home}',
          pageBuilder: (context, state) {
            int initialRegionId = 31;
            String initialRegionName = "DKI JAKARTA";
            return MaterialPage(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<ShrimpPriceBloc>()
                      ..add(ShrimpPriceGetEvent(
                        page: 1,
                        regionId: initialRegionId,
                      )),
                  ),
                  BlocProvider(
                    create: (context) => sl<ShrimpPricesCubit>(),
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) => sl<RegionsBloc>()..add(const RegionsSearchEvent(keyword: '')),
                  ),
                  BlocProvider(
                    create: (context) => sl<FilterCubit>()
                      ..selectRegion(RegionEntity(
                        id: initialRegionId.toString(),
                        fullName: initialRegionName,
                      )),
                  ),
                  BlocProvider(
                    create: (context) => sl<NewsBloc>()
                      ..add(const NewsGetEvent(
                        page: 1,
                        perPage: 15,
                      )),
                  ),
                  BlocProvider(
                    create: (context) => sl<ShrimpNewsCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<DiseaseBloc>()
                      ..add(const DiseaseGetEvent(
                        page: 1,
                        perPage: 15,
                      )),
                  ),
                  BlocProvider(
                    create: (context) => sl<ShrimpDiseaseCubit>(),
                  ),
                ],
                child: const HomeScreen(),
              ),
            );
          },
          routes: [
            GoRoute(
              name: AppRoute.shrimpPrice,
              path: "${AppRoute.shrimpPrice}/:id",
              pageBuilder: (context, state) {
                String? id = state.pathParameters["id"];
                int? regionId = (state.extra as Map?)?["regionId"];
                return MaterialPage(
                  key: state.pageKey,
                  child: BlocProvider(
                    lazy: false,
                    create: (context) => sl<DetailShrimpPriceBloc>()
                      ..add(
                        DetailShrimpPriceGetEvent(
                          id: int.parse(id ?? "0"),
                          regionId: regionId,
                        ),
                      ),
                    child: const ShrimpPriceScreen(),
                  ),
                );
              },
            ),
            GoRoute(
              name: AppRoute.shrimpNews,
              path: "${AppRoute.shrimpNews}/:id",
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: ShrimpNewsScreen(
                  id: state.pathParameters['id'] ?? "",
                ),
              ),
            ),
            GoRoute(
              name: AppRoute.shrimpDisease,
              path: "${AppRoute.shrimpDisease}/:id",
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: ShrimpDiseaseScreen(
                  id: state.pathParameters['id'] ?? "",
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
