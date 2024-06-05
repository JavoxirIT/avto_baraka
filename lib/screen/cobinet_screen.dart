import 'package:avto_baraka/screen/imports/imports_cabinet.dart';

class CobinetScreen extends StatefulWidget {
  const CobinetScreen({Key? key}) : super(key: key);

  @override
  CobinetScreenState createState() => CobinetScreenState();
}

class CobinetScreenState extends State<CobinetScreen> {
  @override
  Widget build(BuildContext context) {
    final providerLanguage = Provider.of<LocalProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);

    BlocProvider.of<ListingActiveBloc>(context).add(
      ListingActiveEventLoad(
        providerLanguage.locale.languageCode,
        tokenProvider.token,
      ),
    );
    BlocProvider.of<ListingBlockedBloc>(context).add(ListingBlockedEventLoad(
      providerLanguage.locale.languageCode,
      tokenProvider.token,
    ));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).kabinet.toUpperCase(),
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          actions: [
            ButtonBar(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteName.contactWithAdmin);
                  },
                  icon: Icon(
                    Icons.support_agent,
                    color: iconSelectedColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteName.settingView);
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: iconSelectedColor,
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: S.of(context).tasdiqlangan),
              Tab(text: S.of(context).bekorQilingan),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BlocBuilder<ListingActiveBloc, ListingActiveState>(
                builder: (context, state) {
              return paddingLayout(
                carCativeCard(context, state, tokenProvider.token, providerLanguage.locale.languageCode),
              );
            }),
            BlocBuilder<ListingBlockedBloc, ListingBlockedState>(
                builder: (context, state) {
              return paddingLayout(
                carBlockedCard(context, state, tokenProvider.token, providerLanguage.locale.languageCode),
              );
            }),
          ],
        ),
      ),
    );
  }
}
