import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'shrimp_disease_tab.dart';
import 'shrimp_news_tab.dart';
import 'shrimp_price_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Jala Media",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: t.lblShrimpPrice,
                ),
                Tab(
                  text: t.lblShrimpNews,
                ),
                Tab(text: t.lblDisease),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ShrimpPriceTab(),
                  ShrimpNewsTab(),
                  ShrimpDiseaseTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
