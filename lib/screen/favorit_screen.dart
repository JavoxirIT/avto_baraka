import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/widgets/car_favirite_card.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:avto_baraka/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  bool isSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    final languageProvider = Provider.of<LocalProvider>(context);

    BlocProvider.of<LikeBloc>(context).add(
      LikeEvendGet(
          token: tokenProvider.token!,
          lang: languageProvider.locale.languageCode),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).tanlanganlar.toUpperCase(),
        ),
      ),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          if (state is LikeStateNotData) {
            return Center(
              child: Text("Sida xozircha tanlangan elonlar mavjut emas"),
            );
          }
          if (state is LikeStateError) {
            return Center(
              child: Text(S.of(context).malumotlarBazasidaXatolik),
            );
          }
          if (state is LikeStateData) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: carFavpriteCard(context, state),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
