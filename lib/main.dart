import "dart:developer";

import "package:avto_baraka/api/service/device_token_service.dart";
import "package:avto_baraka/firebase_options.dart";
import "package:avto_baraka/main_import.dart";
import "package:avto_baraka/provider/send_listing_provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
// import 'package:flutter_background/flutter_background.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
// polucheniye token ustroystva dlya firebase notification
  messaging.getToken().then((token) {
    log(token!);
    DeviseTokenService.DTS.sendDeviceToken(token);
  });

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android?.smallIcon,
              // other properties...
            ),
          ));
    }
  });

  Bloc.observer = const SimpleBlocObserver();

//
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
        child: const AvtoBarakaMainApp(),
      ),
    ),
  );
}

class AvtoBarakaMainApp extends StatefulWidget {
  const AvtoBarakaMainApp({super.key});

  @override
  State<AvtoBarakaMainApp> createState() => _AvtoBarakaMainAppState();
}

class _AvtoBarakaMainAppState extends State<AvtoBarakaMainApp>
    with WidgetsBindingObserver {
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
      // home: const IntroductionScreen(),
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
