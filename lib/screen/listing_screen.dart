import 'package:avto_baraka/screen/imports/imports_listing.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  String? token;
  List<CarCategoryModels> categoryList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.forward();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        leadingWidth: MediaQuery.of(context).size.width / 2.5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.creditBankListScreen);
            },
            style: elevatedButton,
            child: Text(
              S.of(context).kreditKalkulatori,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.searchView);
              },
              icon: const Icon(FontAwesomeIcons.sliders),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ListingBloc, ListingState>(
        builder: (context, state) {
          if (state is ListingStateNoDataSearch) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          S.of(context).kechirasiz,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        content: Text(
                          S.of(context).malumotTopilmadi,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() {}); // Ensure mounted before setState
                    }
                  });
                }
              },
            );
          }

          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 15.0),
                  child: Text(
                    S.of(context).kategoriyalar,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              flutterCarousel(context, categoryList),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: carCard(context, state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    setState(() {});
  }
}
