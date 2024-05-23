import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/widgets/car_favirite_card.dart';
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
      LikeEvendGet(languageProvider.locale.languageCode, tokenProvider.token!),
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
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: carFavpriteCard(context, state, tokenProvider.token!, languageProvider.locale.languageCode),
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
