import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cores/configs/app_theme.dart';
import '../cores/depedency_injections/depedency_injection.dart';
import '../cores/routing/app_navigation.dart';
import 'language/presentation/cubit/languages_cubit.dart';

class App extends StatelessWidget {
  final String initialRoute;
  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    var goRouter = AppNavigation.router(initialRoute);
    return BlocProvider(
      create: (context) => sl<LanguagesCubit>()..init(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlocBuilder<LanguagesCubit, LanguagesStateData>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Udangss',
              theme: AppTheme.mainTheme(),
              // darkTheme: ThemeData.dark(),
              // themeMode: ThemeMode.system,
              locale: state.selectedLocale,
              supportedLocales: state.locales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerDelegate: goRouter.routerDelegate,
              routeInformationParser: goRouter.routeInformationParser,
              routeInformationProvider: goRouter.routeInformationProvider,
            );
          },
        ),
      ),
    );
  }
}
