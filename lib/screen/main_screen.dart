import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/service/car_service.dart';
import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:avto_baraka/provider/keyboard_provider.dart';
import 'package:avto_baraka/screen/imports/imports_maim.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<CarCategoryModels>? categoryList;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  int count = -1;
  final double sizecontainersize = 30.0;
  int _selectedIndex = 0;

// loading
  bool showLoadingIndicator = true;
  // late AnimationController _controller;
  // late Animation<double> _animation;
  // late Animation<Offset> _animation;
  // late Timer _timer;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getData();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    // _controller.dispose();
    // _timer.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          body: GestureDetector(
            onTap: () {
              Provider.of<KeyboardVisibilityController>(context, listen: false)
                  .hideKeyboard(context);
            },
            child: Center(
              child: screenList.elementAt(_selectedIndex),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 55.0,
            key: bottomNavigationKey,
            index: 0,
            items: curvedNavigationBarItem,
            color: colorEmber,
            buttonBackgroundColor: colorEmber,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: _onItemTapped,
            letIndexChange: (index) => true,
          ),
        ),
      ],
    );
  }

  List<Widget> get curvedNavigationBarItem {
    return <Widget>[
      _buildNavigationItem(Icons.home, 0),
      _buildNavigationItem(FontAwesomeIcons.heartCircleCheck, 1),
      _buildNavigationItem(FontAwesomeIcons.plus, 2),
      _buildNavigationItemWithBadge(Icons.messenger_sharp, 3),
      _buildNavigationItem(Icons.airplay_rounded, 4),
    ];
  }

  Widget _buildNavigationItem(IconData icon, int index) {
    return Center(
      child: ClipOval(
        child: Container(
          color: Colors.black,
          width: sizecontainersize,
          height: sizecontainersize,
          child: Icon(
            icon,
            color: _selectedIndex == index ? Colors.white : colorEmber,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItemWithBadge(IconData icon, int index) {
    return ClipOval(
      child: Container(
        color: Colors.black,
        alignment: Alignment.center,
        width: sizecontainersize,
        height: sizecontainersize,
        child: count > 0
            ? Badge(
                backgroundColor: colorWhite,
                label: Text(
                  count.toString(),
                  style: TextStyle(
                    color: cardBlackColor,
                  ),
                ),
                child: Icon(
                  icon,
                  color: _selectedIndex == index ? colorWhite : colorEmber,
                ),
              )
            : Icon(
                icon,
                color: _selectedIndex == index ? colorWhite : colorEmber,
              ),
      ),
    );
  }

  _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _connectionStatus = result;
      if (result.toString() == [ConnectivityResult.none].toString()) {
        Navigator.of(context).pushNamed(RouteName.internetConnection);
      }
    });
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    count = await ChatService.chatService.unreadMessages();
    if (mounted) {
      setState(() {});
    }
  }
}
