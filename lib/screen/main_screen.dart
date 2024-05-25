import 'package:avto_baraka/screen/imports/imports_maim.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu>
    with SingleTickerProviderStateMixin {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  int _selectedIndex = 0;

// loading
  bool showLoadingIndicator = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // ::::::::::::::::::::: loading
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 3000), () {
        setState(() {
          showLoadingIndicator = false;
        });
      });
    });

    // _timer = Timer(const Duration(milliseconds: 2000), () {
    //   _controller.forward();
    //   setState(() {
    //     showLoadingIndicator = false;
    //   });
    // });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _controller.dispose();
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    const double size = 18.0;
    if (_connectionStatus.toString() == [ConnectivityResult.none].toString()) {
      return const CheckingInternetConnection(title: "Title");
    }
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: screenList.elementAt(_selectedIndex),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            margin: const EdgeInsets.only(top: 12, left: 10, right: 10),
            height: 65.0,
            width: 65.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.announcement);
              },
              backgroundColor: iconSelectedColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 3.0,
                  color: iconSelectedColor,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: const Icon(FontAwesomeIcons.plus,
                  color: Colors.white, size: 34.0),
            ),
          ),
          bottomNavigationBar:
              bottomNavItem(_onItemTapped, _selectedIndex, size, context),
        ),
        if (showLoadingIndicator)
          FadeTransition(
            opacity: _animation,
            child: Container(
              decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
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
}
