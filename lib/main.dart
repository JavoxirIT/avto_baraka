import 'package:avto_baraka/api/service/payments__service.dart';
import 'package:avto_baraka/bloc/not_active/not_active_bloc.dart';
import 'package:avto_baraka/bloc/payment/payment_bloc.dart';
import 'package:avto_baraka/observer/simple_bloc_observer.dart';
import 'package:avto_baraka/router/navigator_key.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:avto_baraka/bloc/all_rooms/all_rooms_bloc.dart';
import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/bloc/listing_active/listing_active_bloc.dart';
import 'package:avto_baraka/bloc/listing_blocked/listing_blocked_bloc.dart';
import 'package:avto_baraka/bloc/one_room/one_room_bloc.dart';
import 'package:avto_baraka/bloc/web_socet_bloc/web_socket_bloc.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/observer/share_route_observer.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/notification_service.dart';
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
  Bloc.observer = const SimpleBlocObserver();
  // ignore: prefer_const_constructors
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "App is running in background",
    notificationText: "Tap to return to the app",
    notificationImportance: AndroidNotificationImportance.Default,
  );

  bool hasPermissions = await FlutterBackground.hasPermissions;
  if (!hasPermissions) {
    await FlutterBackground.initialize(androidConfig: androidConfig);
    await FlutterBackground.enableBackgroundExecution();
  }

  final notificationService = NotificationService();
  await notificationService.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  LocalProvider languageProvider = LocalProvider();
  await languageProvider.fetchLocale();

  TokenProvider tokenProvider = TokenProvider();
  await tokenProvider.fetchTokenLocale();
  final webSocketBloc =
      WebSocketBloc(notificationService, ChatService.chatService);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider(create: (_) => tokenProvider),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ListingBloc>(
            create: (context) => ListingBloc(ListingService.servive)
              ..add(
                const ListingEventLoad(),
              ),
          ),
          BlocProvider<ListingActiveBloc>(
            create: (context) => ListingActiveBloc(ListingService.servive),
          ),
          BlocProvider<ListingBlockedBloc>(
            create: (context) => ListingBlockedBloc(ListingService.servive),
          ),
          BlocProvider<LikeBloc>(
            create: (context) => LikeBloc(ListingService.servive),
          ),
          BlocProvider<AllRoomsBloc>(
            create: (context) => AllRoomsBloc(ChatService.chatService),
          ),
          BlocProvider(
            create: (context) => webSocketBloc
              ..add(
                ConnectWebSocket(url: Config.ws!),
              ),
          ),
          BlocProvider<OneRoomBloc>(
            create: (context) =>
                OneRoomBloc(ChatService.chatService, webSocketBloc),
          ),
          BlocProvider(
            create: (context) => PaymentBloc(PaymentsService.ps),
          ),
          BlocProvider(
            create: (context) => NotActiveBloc(ListingService.servive),
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
    super.initState();
  }

  @override
  Widget build(context) {
    // final tokenProvider = Provider.of<TokenProvider>(context);
    final providerLanguage = Provider.of<LocalProvider>(context);
    PaymentsService().paymentDesc(providerLanguage.locale.languageCode);

    return MaterialApp(
      navigatorKey: navigatorKey,
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
      theme: defaultTheme(),
      routes: routers,
      home: token != null ? const MainScreen() : const IntroductionScreen(),
    );
  }

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
