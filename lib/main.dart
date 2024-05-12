import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/routers.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/view/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  var languageProvider = LocalProvider();
  await languageProvider.fetchLocale();

// token
  var tokenProvider = TokenProvider();
  await tokenProvider.fetchTokenLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider(create: (_) => tokenProvider)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool isActivateKey = false;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LocalProvider()),
          ChangeNotifierProvider(create: (context) => TokenProvider())
        ],
        builder: (context, chil) {
          final providerLanguage = Provider.of<LocalProvider>(context);
          final tokenProvider = Provider.of<TokenProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: providerLanguage.locale,
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark,
            // ),

            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              // /brightness: Brightness.light,
              // primaryColor: Colors.red,
              fontFamily: "Roboto",
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
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
              cardTheme: CardTheme(
                // shape: Border.all(width: 1.0, color: const Color.fromARGB(255, 214, 214, 214), )
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 214, 214, 214), // Цвет границы
                    width: 0.5, // Ширина границы
                  ),
                ),
                elevation: 0,
                // shadowColor: Colors.black,
                color: backgrounColorWhite,
                surfaceTintColor: backgrounColorWhite,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                errorStyle: TextStyle(fontSize: 10.0),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                unselectedLabelStyle: const TextStyle(fontSize: 10.0),
                unselectedItemColor: unselectedItemColor,
                selectedLabelStyle: const TextStyle(fontSize: 10.0),
                selectedItemColor: iconSelectedColor,
              ),
              textTheme: const TextTheme(
                displayLarge:
                    TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
                displayMedium: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
                displaySmall: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                bodySmall: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            routes: routers,
            // home: tokenProvider != ""
            //     ? const BottomNavigationMenu()
            //     : const IntroductionScreen(),
            home: const LoadingView(),
          );
        },
      );
}
