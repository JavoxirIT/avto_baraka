import "package:avto_baraka/main_import.dart";
import "package:avto_baraka/provider/send_listing_provider.dart";

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();

  // const androidConfig = FlutterBackgroundAndroidConfig(
  //   notificationTitle: "Ilova fonda ishlayapti",
  //   notificationText: "Ilovaga qaytish uchun bosing",
  //   notificationImportance: AndroidNotificationImportance.Default,
  //   notificationIcon:
  //       AndroidResource(name: 'background_icon', defType: 'drawable'),
  // );

  // bool hasPermissions = await FlutterBackground.hasPermissions;
  // if (!hasPermissions) {
  //   await FlutterBackground.initialize(androidConfig: androidConfig);
  //   await FlutterBackground.enableBackgroundExecution();
  // }

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
        ChangeNotifierProvider(create: (_) => SendListingProvider()),
        ChangeNotifierProvider(
          create: (context) => KeyboardVisibilityController(),
        ),
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
              create: (context) =>
                  webSocketBloc..add(ConnectWebSocket(url: Config.ws!))),
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
    BlocProvider.of<WebSocketBloc>(context)
        .add(ConnectWebSocket(url: Config.ws!));
    getLocalData();
    super.initState();
  }

  @override
  Widget build(context) {
    // final tokenProvider = Provider.of<TokenProvider>(context);
    final providerLanguage = Provider.of<LocalProvider>(context);
    PaymentsService().paymentDesc();

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
