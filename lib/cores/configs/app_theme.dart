import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';

class AppTheme {
  static ThemeData mainTheme() => ThemeData(
        primaryColor: clrBlue,
        // scaffoldBackgroundColor: clrBackgroundBlack,
        fontFamily: GoogleFonts.lato().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: clrBlue,
          titleTextStyle: TextStyle(
            color: clrWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: clrWhite),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: clrBlue,
          unselectedLabelColor: clrGrey77,
          dividerHeight: 4.0,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0, color: clrBlue),
            insets: EdgeInsets.zero,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: titleLarge(),
          titleMedium: titleMedium(),
          titleSmall: titleSmall(),
          bodyLarge: bodyLarge(),
          bodyMedium: bodyMedium(),
          bodySmall: bodySmall(),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  static TextStyle titleLarge() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: clrBlack45,
      );

  static TextStyle titleMedium() => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: clrBlack45,
      );

  static TextStyle titleSmall() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: clrBlack45,
      );

  static TextStyle bodyLarge() => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: clrBlack45,
      );

  static TextStyle bodyMedium() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: clrBlack45,
      );

  static TextStyle bodySmall() => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: clrBlack45,
      );
}
