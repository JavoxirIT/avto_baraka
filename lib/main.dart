// import 'package:avto_baraka/screen/introductory_screen.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/routers.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/bottom_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: const [
      //   Locale('uz', 'UZ'),
      //   Locale('ru', 'RU'),
      // ],
      locale: Locale('uz', 'UZ'),
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        fontFamily: "Roboto",
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto"),
        ),
        tabBarTheme: const TabBarTheme(
          // верхняя часть app bara
          overlayColor: MaterialStatePropertyAll(Colors.white),
          dividerHeight: 0.0,
          labelStyle: TextStyle(
            fontFamily: "Roboto",
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
          labelColor: Colors.white,
        ),
        // useMaterial3: true,
        cardTheme: CardTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          elevation: 2.0,
          color: backgrounColorWhite,
        ),
      ),
      routes: routers,
      // home: const IntroductionScreen(),
      home: const BottomNavigationMenu(),
    );
  }
}
