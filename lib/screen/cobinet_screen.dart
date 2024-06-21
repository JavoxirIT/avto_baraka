import 'package:avto_baraka/bloc/not_active/not_active_bloc.dart';
import 'package:avto_baraka/screen/imports/imports_cabinet.dart';
import 'package:avto_baraka/widgets/car_not_active.dart';

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
          providerLanguage.locale.languageCode, tokenProvider.token),
    );
    BlocProvider.of<ListingBlockedBloc>(context).add(ListingBlockedEventLoad(
      providerLanguage.locale.languageCode,
      tokenProvider.token,
    ));
    BlocProvider.of<NotActiveBloc>(context).add(NotActiveEventLoad(
      lang: providerLanguage.locale.languageCode,
      token: tokenProvider.token!,
    ));

    return DefaultTabController(
      length: 3,
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
                    Navigator.of(context).pushNamed(RouteName.firstChat,
                        arguments: {"userId": 0});
                  },
                  icon: Icon(
                    Icons.support_agent,
                    color: colorEmber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteName.settingView);
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: colorEmber,
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Widget>[
              Tab(text: S.of(context).tasdiqlangan),
              Tab(text: S.of(context).faolEmas),
              Tab(text: S.of(context).bekorQilingan),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: TabBarView(
            children: <Widget>[
              CarActiveCard(
                token: tokenProvider.token!,
                lang: providerLanguage.locale.languageCode,
              ),
              CarNotActiv(
                token: tokenProvider.token,
                languageCode: providerLanguage.locale.languageCode,
              ),
              CarBlockedCard(
                token: tokenProvider.token!,
                lang: providerLanguage.locale.languageCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
