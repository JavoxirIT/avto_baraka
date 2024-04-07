import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/screen/announcement.dart';
import 'package:avto_baraka/screen/chat_screen.dart';
import 'package:avto_baraka/screen/cobinet_screen.dart';
import 'package:avto_baraka/screen/favorit_screen.dart';
import 'package:avto_baraka/view/one_car.dart';
import 'package:avto_baraka/widgets/bottom_navigation_menu.dart';

final routers = {
  RouteName.bottomNavigationHomeScreen: (_) => const BottomNavigationMenu(),
  RouteName.favoritScreen: (_) => const FavoritScreen(),
  RouteName.chatScreen: (_) => const ChatScreen(),
  RouteName.cobinetScreen: (_) => const CobinetScreen(),
  RouteName.oneCarView: (_) => const OneCarView(),
  RouteName.announcement: (_) => const Announcement(),
};
