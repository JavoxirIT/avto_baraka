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
      ),
    );
  }
}
