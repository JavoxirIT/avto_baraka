import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/screen/announcement.dart';
import 'package:avto_baraka/screen/chat_screen.dart';
import 'package:avto_baraka/screen/cobinet_screen.dart';
import 'package:avto_baraka/view/credit/credit_%20graphic_view.dart';
import 'package:avto_baraka/view/credit/credit_first_view.dart';
import 'package:avto_baraka/screen/favorit_screen.dart';
import 'package:avto_baraka/view/credit/credit_second_view.dart';
import 'package:avto_baraka/view/one_car.dart';
import 'package:avto_baraka/view/setting_view/setting_view.dart';
import 'package:avto_baraka/widgets/bottom_navigation_menu.dart';

final routers = {
  RouteName.bottomNavigationHomeScreen: (_) => const BottomNavigationMenu(),
  RouteName.favoritScreen: (_) => const FavoritScreen(),
  RouteName.chatScreen: (_) => const ChatScreen(),
  RouteName.cobinetScreen: (_) => const CobinetScreen(),
  RouteName.oneCarView: (_) => const OneCarView(),
  RouteName.announcement: (_) => const Announcement(),
  RouteName.creditBankListScreen: (_) => const CreditFirstView(),
  RouteName.creditSecondView: (_) => const CreditSecondView(),
  RouteName.creditGraphicView: (_) => const CreditGraphicView(),
  RouteName.settingView: (_) => const SettingView(),
};
