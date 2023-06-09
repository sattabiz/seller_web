import 'package:flutter/material.dart';
import '/theme/theme_colors.dart';
import '/theme/typography.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: themeColor,
  textTheme: themeText,
  navigationRailTheme: const NavigationRailThemeData().copyWith(
    backgroundColor: themeColor.primary,
  ),
  navigationDrawerTheme: const NavigationDrawerThemeData().copyWith(),
  elevatedButtonTheme: elevatedButtonTheme,
  cardTheme: cardTheme,
  dataTableTheme: dataTableTheme,

);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: themeColor.primary,
    textStyle: themeText.labelLarge,
    elevation: 2,
  ),
);

final cardTheme = CardTheme(
    color: themeColor.surfaceVariant,
    elevation: 4
);

final dataTableTheme = const DataTableThemeData().copyWith(
  // decoration:  BoxDecoration(
  //   // borderRadius: BorderRadius.all(Radius.circular(10)),
  //   color: themeColor.onPrimary,
  //   border: Border.all(
  //     color: Colors.transparent,
  //     // width: 3,
  //     // strokeAlign: BorderSide.strokeAlignInside,
  //   ),
    
  // ),
  // headingTextStyle: themeText.labelMedium,
  // // headingRowColor: MaterialStateProperty.all<Color>(themeColor.primary),
  // dataTextStyle: themeText.bodySmall,
  // dataRowMaxHeight: 16,
  


);