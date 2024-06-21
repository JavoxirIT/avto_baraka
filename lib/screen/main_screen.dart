import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/service/car_service.dart';
import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:avto_baraka/screen/imports/imports_maim.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
  int? count;
  final double sizecontainersize = 30.0;
  int _selectedIndex = 0;

// loading
  bool showLoadingIndicator = true;
  late AnimationController _controller;
  // late Animation<double> _animation;
  late Animation<Offset> _animation;
  late Future<void> _initialization;
  // late Timer _timer;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _initialization = getData();

    _initialization.then((_) {
      _controller.forward().then((_) {
        if (categoryList!.isNotEmpty) {
          Future.delayed(const Duration(seconds: 6), () {
            showLoadingIndicator = false;
          });
        }
      });
    });

    // ::::::::::::::::::::: loading
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -3),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _controller.dispose();
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
    _controller.forward();
    if (_connectionStatus.toString() == [ConnectivityResult.none].toString()) {
      return const CheckingInternetConnection(title: "Title");
    }
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          body: Center(
            child: screenList.elementAt(_selectedIndex),
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
        if (showLoadingIndicator)
          SlideTransition(
            position: _animation,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgBlack), fit: BoxFit.cover),
              ),
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
        child: count != 0
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
                  color:
                      _selectedIndex == index ? colorWhite : colorEmber,
                ),
              )
            : Icon(
                icon,
                color: _selectedIndex == index ? colorWhite : colorEmber,
              ),
      ),
    );
  }

  // Сообщения платформы асинхронны, поэтому мы инициализируем их в асинхронном методе.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Сообщения платформы могут давать сбои, поэтому мы используем try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status,  $e');
      return;
    }

// Если виджет был удален из дерева, пока асинхронное сообщение платформы
// находилось в пути, мы хотим отменить ответ, а не вызывать
// setState для обновления нашего несуществующего внешнего вида.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    // print('Connectivity changed: $_connectionStatus');
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    count = await ChatService.chatService.unreadMessages();
    if (mounted) {
      setState(() {});
    }
  }
}
