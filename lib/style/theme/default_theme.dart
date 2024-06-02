import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/page_transition.dart';
import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    pageTransitionsTheme: pageTransitions(),
    colorScheme: ColorScheme.light(primary: iconSelectedColor),
    scaffoldBackgroundColor: Colors.white,
    // /brightness: Brightness.light,
    // primaryColor: Colors.red,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    fontFamily: "Roboto",
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          fontFamily: "Roboto"),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: iconSelectedColor,
      dividerHeight: BorderSide.strokeAlignCenter,
      labelColor: iconSelectedColor,
      overlayColor: const MaterialStatePropertyAll(Colors.white),
      // labelStyle: const TextStyle(
      //   fontFamily: "Roboto",
      //   fontSize: 14.0,
      //   fontWeight: FontWeight.w700,
      // ),
      // dividerColor: Colors.blueAccent
    ),

    cardTheme: CardTheme(
      // shape: Border.all(width: 1.0, color: const Color.fromARGB(255, 214, 214, 214), )
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 214, 214, 214), // Цвет границы
          width: 0.5, // Ширина границы
        ),
      ),
      elevation: 1,
      shadowColor: iconSelectedColor,
      color: backgrounColorWhite,
      surfaceTintColor: backgrounColorWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(fontSize: 10.0),
      hintStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
      labelStyle: TextStyle(
          color: iconSelectedColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedLabelStyle: const TextStyle(fontSize: 10.0),
      unselectedItemColor: unselectedItemColor,
      selectedLabelStyle: const TextStyle(fontSize: 10.0),
      selectedItemColor: iconSelectedColor,
    ),
    dropdownMenuTheme:
        const DropdownMenuThemeData(textStyle: TextStyle(fontSize: 12.0)),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0)), // Задаем скругление верхних углов
      ),
      backgroundColor: Colors.blueGrey, // Задаем цвет фона
      elevation: 10, // Задаем тень
      modalBackgroundColor: Color.fromARGB(
          248, 255, 255, 255), // Задаем прозрачный цвет фона для анимации
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Color.fromARGB(255, 247, 247, 247),
    ),
    textTheme: TextTheme(
      labelLarge: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
      displayLarge:
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
      displayMedium: const TextStyle(
        fontSize: 12.0,
        color: Colors.white,
      ),
      displaySmall: const TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      // BODY
      bodyLarge: TextStyle(
        fontSize: 14.0,
        color: iconSelectedColor,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontSize: 13.0,
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
      bodySmall: const TextStyle(
        fontSize: 10.0,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    ),

    // snackBarTheme: SnackBarThemeData(
    //   contentTextStyle: TextStyle(
    //       backgroundColor: iconSelectedColor,
    //       fontSize: 18.0,
    //       fontWeight: FontWeight.w800),
    // ),
  );
}
