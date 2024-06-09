import 'package:flutter/material.dart';

import 'cores/configs/environment.dart';
import 'cores/routing/app_route.dart';
import 'feratures/app.dart';
import 'cores/depedency_injections/depedency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.flavor = EFlavor.prod;
  await Future.wait([
    di.init(),
  ]);
  final initialRoute = await AppRoute.initialRoute;
  runApp(App(initialRoute: initialRoute));
}
