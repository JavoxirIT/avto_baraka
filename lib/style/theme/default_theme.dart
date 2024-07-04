import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/page_transition.dart';
import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    pageTransitionsTheme: pageTransitions(),

    // colorScheme: ColorScheme.light(primary: colorWhite),
    scaffoldBackgroundColor: Colors.black,
    // /brightness: Brightness.light,
    // primaryColor: Colors.red,
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(colorEmber),
      thickness: const MaterialStatePropertyAll(5.0),
      trackVisibility: const MaterialStatePropertyAll(true),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: cardBlackColor,
      surfaceTintColor: colorWhite,
    ),
    fontFamily: "Roboto",
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: colorWhite,
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        fontFamily: "Roboto",
      ),
      actionsIconTheme: IconThemeData(color: colorWhite),
      iconTheme: IconThemeData(
        color: colorWhite,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: colorEmber,
      dividerHeight: BorderSide.strokeAlignCenter,
      labelColor: colorEmber,
      overlayColor: MaterialStatePropertyAll(colorWhite),
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
          // color: Color.fromARGB(255, 214, 214, 214), // Цвет границы
          width: 0, // Ширина границы
        ),
      ),
      // elevation: 1,
      shadowColor: colorEmber,
      color: cardBlackColor,
      surfaceTintColor: backgrounColorWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(fontSize: 10.0),
      hintStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
      labelStyle: TextStyle(
        color: colorEmber,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorWhite,
      unselectedLabelStyle: const TextStyle(fontSize: 10.0),
      unselectedItemColor: unselectedItemColor,
      selectedLabelStyle: const TextStyle(fontSize: 10.0),
      selectedItemColor: colorEmber,
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
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
    ),
    iconTheme: const IconThemeData(color: Colors.black, size: 18.0),
    textTheme: TextTheme(
      labelLarge: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
      labelMedium: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
      ),
      displayLarge:
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
        fontSize: 12.0,
        color: colorWhite,
      ),
      displaySmall: TextStyle(
        fontSize: 12.0,
        color: colorWhite,
        fontWeight: FontWeight.w700,
      ),
      // BODY
      bodyLarge: TextStyle(
        fontSize: 14.0,
        color: colorEmber,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontSize: 13.0,
        color: const Color.fromARGB(255, 253, 253, 253).withOpacity(1),
        fontWeight: FontWeight.w500,
      ),
      bodySmall: const TextStyle(
        fontSize: 10.0,
        color: Color.fromARGB(255, 255, 255, 255),
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
