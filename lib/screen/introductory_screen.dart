import 'package:avto_baraka/screen/imports/imports_introductory.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});
  @override
  State<IntroductionScreen> createState() => _MainPageState();
}

class _MainPageState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  CarouselController buttonCarouselController = CarouselController();
  int _currentPosition = 0;

  bool onNextPage = false;
  bool showLoadingIndicator = true;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -3),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        showLoadingIndicator = false;
      });
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 2;
    final double heightImage = MediaQuery.of(context).size.height / 5;

    List<Map<String, dynamic>> list = mainCarouselItem(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<TokenProvider>(
          builder: (context, tokenProvider, _) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: FlutterCarousel(
                        items: list
                            .map(
                              (item) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: item["image"] is int
                                        ? fourthcard(context, item)
                                        : item["image"] is Widget
                                            ? item["image"]
                                            : Image.asset(
                                                item["image"],
                                                fit: BoxFit.contain,
                                                height: heightImage,
                                              ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  textcard(item),
                                ],
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          showIndicator: false,
                          autoPlay: false,
                          controller: buttonCarouselController,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          initialPage: 0,
                          height: height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPosition = index;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _currentPosition == 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: const Color(0xffd9d9d9),
                                      padding: const EdgeInsets.all(15.0)),
                                  onPressed: () {},
                                  child: const Icon(Icons.circle,
                                      color: Colors.black),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: colorEmber,
                                      padding: const EdgeInsets.all(15.0)),
                                  onPressed: () {
                                    buttonCarouselController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new,
                                      color: Colors.white),
                                ),
                          DotsIndicator(
                            dotsCount: list.length,
                            position: _currentPosition,
                            decorator: DotsDecorator(
                              activeColor: colorEmber,
                              color: const Color(0XFFd9d9d9),
                              size: const Size(15.0, 15.0),
                              activeSize: const Size(15.0, 15.0),
                            ),
                          ),
                          _currentPosition == 3
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: tokenProvider.token == null
                                        ? unselectedItemColor
                                        : colorEmber,
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  onPressed: () {
                                    if (tokenProvider.token == null) {
                                      return;
                                    } else {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        RouteName.mainScreen,
                                        (route) => false,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: colorEmber,
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                  onPressed: () {
                                    buttonCarouselController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                  child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white),
                                ),
                        ],
                      ),
                    ),
                  ],
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
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  Padding textcard(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
      child: Center(
        child: Text(
          item['text'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: colorWhite,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Container fourthcard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: backgnColStepCard,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          color: cardCashColor,
        ),
      ),
      width: MediaQuery.of(context).size.width / 1.2,
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      child: Text(
        item["image"].toString(),
        style: TextStyle(
          color: colorEmber,
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
