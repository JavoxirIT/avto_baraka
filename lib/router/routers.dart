import 'package:avto_baraka/router/route_impoer.dart';

final routers = {
  RouteName.introduction: (_) => const IntroductionScreen(),
  RouteName.bottomNavigationHomeScreen: (_) => const BottomNavigationMenu(),
  RouteName.favoritScreen: (_) => const FavoriteScreen(),
  RouteName.chatScreen: (_) => const ChatScreen(),
  RouteName.cobinetScreen: (_) => const CobinetScreen(),
  RouteName.oneCarView: (_) => const OneCarView(),
  RouteName.announcement: (_) => const Announcement(),
  RouteName.creditBankListScreen: (_) => const CreditFirstView(),
  RouteName.creditSecondView: (_) => const CreditSecondView(),
  RouteName.creditGraphicView: (_) => const CreditGraphicView(),
  RouteName.settingView: (_) => const SettingView(),
  RouteName.settingUserView: (_) => const SettingUserView(),
  RouteName.contactWithAdmin: (_) => const ContactWithAdmin(),
  RouteName.firstpayView: (_) => const FirstPayFormView(),
  RouteName.fullScreenImage: (_) => const FullScreenImage(),
  RouteName.searchView: (_) => const SearchView(),
  RouteName.oneChat: (_) => const Chat(),
  RouteName.chatTwo: (_) => const FirstChat(),
  RouteName.loginToAnotherAccount: (_) => const LoginToAnotherAccount(),
};
