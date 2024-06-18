import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/screen/imports/imports_cabinet.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/sized_box_10.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  String? token;
  List<CarCategoryModels> categoryList = [];
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getData();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ListingBloc>().add(const ListingEventLoad());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avto Baraka".toUpperCase()),
        toolbarHeight: 40.0,
        leadingWidth: MediaQuery.of(context).size.width / 2.5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.searchView);
              },
              icon: Icon(FontAwesomeIcons.sliders, color: iconSelectedColor),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: iconSelectedColor,
        strokeWidth: 3.0, // Толщина линии индикатора
        displacement: 150.0, // Сдвиг индикатора от верхней части экрана
        onRefresh: () async {
          // Отправляем событие для загрузки данных
          context.read<ListingBloc>().add(ListingEventRefresh());
          // Используем Completer для завершения refresh-индикатора
          final completer = Completer<void>();
          final subscription =
              context.read<ListingBloc>().stream.listen((state) {
            if (state.status == ListingStatus.success) {
              if (!completer.isCompleted) {
                completer.complete();
              }
            } else if (state is ListingStateError) {
              if (!completer.isCompleted) {
                completer.completeError(state.exception);
              }
            }
          });
          // Ожидаем завершения или ошибки
          await completer.future;
          // Отписываемся от событий
          await subscription.cancel();
          return completer.future;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            flutterCarousel(context, categoryList),
            sizedBox10,
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: CarCard(
                  scrollController: _scrollController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    if (mounted) {
      setState(() {});
    }
  }
}
