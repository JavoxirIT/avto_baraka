import 'package:avto_baraka/router/route_impoer.dart';
import 'package:avto_baraka/view/checking_internet_connection.dart';


final routers = {
  RouteName.introduction: (_) => const IntroductionScreen(),
  RouteName.mainScreen: (_) => const MainScreen(),
  RouteName.favoritScreen: (_) => const FavoriteScreen(),
  RouteName.chatScreen: (_) => const ChatScreen(),
  RouteName.cobinetScreen: (_) => const CobinetScreen(),
  RouteName.oneCarView: (_) => const OneCarView(),
  RouteName.announcement: (_) => const Announcement(),
  RouteName.creditScreen: (_) => const CreditScreen(),
  RouteName.settingView: (_) => const SettingView(),
  RouteName.settingUserView: (_) => const SettingUserView(),
  RouteName.firstpayView: (_) => const FirstPayFormView(),
  RouteName.fullScreenImage: (_) => const FullScreenImage(),
  RouteName.searchView: (_) => const SearchView(),
  RouteName.chat: (_) => const Chat(),
  RouteName.firstChat: (_) => const FirstChat(),
  RouteName.loginToAnotherAccount: (_) => const LoginToAnotherAccount(),
  RouteName.ratesView: (_) => const RatesView(),
  RouteName.privacyWeb: (_) => const PrivacyWeb(),
  RouteName.termsConditionWeb: (_) => const TermsConditionWeb(),
  RouteName.internetConnection: (_) => const CheckingInternetConnection(title: "")
};
