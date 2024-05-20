import 'package:avto_baraka/bloc/listing_active/listing_active_bloc.dart';
import 'package:avto_baraka/bloc/listing_blocked/listing_blocked_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/car_active.card.dart';
import 'package:avto_baraka/widgets/car_blocked_card.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 152.0,
              title: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).kabinet.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      ButtonBar(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.contactWithAdmin);
                            },
                            icon: Icon(
                              Icons.support_agent,
                              color: iconSelectedColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.settingView);
                            },
                            icon: Icon(
                              Icons.settings_outlined,
                              color: iconSelectedColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  color: backgrounColor,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      S.of(context).meningHisobim,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      "210 000 so`m",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: iconSelectedColor),
                    ),
                    trailing: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.credit_card,
                          color: iconSelectedColor,
                          size: 28.0,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ]),
              pinned: true,
              floating: true,
              bottom: TabBar(
                // tabAlignment: TabAlignment.center,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -10.0,
                  vertical: 0.0,
                ),
                // indicatorColor: iconSelectedColor,
                indicator: BoxDecoration(
                  color: iconSelectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
                // isScrollable: true,
                labelStyle: Theme.of(context).textTheme.displaySmall,

                tabs: [
                  Tab(text: S.of(context).tasdiqlangan),
                  Tab(text: S.of(context).bekorQilingan),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            BlocBuilder<ListingActiveBloc, ListingActiveState>(
                builder: (context, state) {
              return paddingLayout(
                carCativeCard(context, state),
              );
            }),
            BlocBuilder<ListingBlockedBloc, ListingBlockedState>(
                builder: (context, state) {
              return paddingLayout(
                carBlockedCard(context, state),
              );
            }),
          ],
        ),
      )),
    );
  }
}
