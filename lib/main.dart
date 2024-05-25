import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/bloc/listing_active/listing_active_bloc.dart';
import 'package:avto_baraka/bloc/listing_blocked/listing_blocked_bloc.dart';
import 'package:avto_baraka/observer/share_route_observer.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/routers.dart';
import 'package:avto_baraka/screen/introductory_screen.dart';
import 'package:avto_baraka/style/theme/default_theme.dart';
import 'package:avto_baraka/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ListingBloc>(
            create: (context) => ListingBloc(ListingService.servive),
          ),
          BlocProvider<ListingActiveBloc>(
            create: (context) => ListingActiveBloc(ListingService.servive),
          ),
          BlocProvider<ListingBlockedBloc>(
            create: (context) => ListingBlockedBloc(ListingService.servive),
          ),
          BlocProvider<LikeBloc>(
            create: (context) => LikeBloc(ListingService.servive),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String? token;
  @override
  void initState() {
    getLocalData();
    // WidgetsBinding.instance.addObserver(this);
    // refreshAppState(); // Восстанавливаем состояние при запуске приложения
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     // Приложение ушло в фон
  //     print('Приложение ушло в фон');
  //     // saveAppState();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // Приложение вернулось из фона
  //     print('Приложение вернулось из фона');
  //     // refreshAppState();
  //   }
  // }

  @override
  Widget build(context) {
    final providerLanguage = Provider.of<LocalProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);
    BlocProvider.of<ListingBloc>(context).add(ListingEventLoad(
        providerLanguage.locale.languageCode, tokenProvider.token));
    return MaterialApp(
      navigatorObservers: [ShareRouteObserver()],
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

      theme: defaultTheme(),
      routes: routers,
      home: token != null
          ? const BottomNavigationMenu()
          : const IntroductionScreen(),
    );
  }

  // Future<void> saveAppState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('currentPage', _currentPage);
  //   print('Состояние приложения сохранено');
  // }

  // Future<void> refreshAppState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Восстанавливаем сохраненное состояние
  //   int? currentPage = prefs.getInt('currentPage');

  //   // Устанавливаем сохраненное состояние в виджеты
  //   if (currentPage != null) {
  //     setState(() {
  //       _currentPage = currentPage;
  //     });
  //   }

  //   print('Состояние приложения восстановлено');
  // }

  Future<void> getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString("access_token");
    if (savedToken != null) {
      setState(() {
        token = savedToken;
      });
    }
  }
}
