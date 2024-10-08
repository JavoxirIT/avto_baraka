import "package:avto_baraka/screen/imports/imports_favorite.dart";
import "package:avto_baraka/style/colors.dart";

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
              child: Text(
                S.of(context).tanlanganElonlarMavjutEmas,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: colorWhite),
              ),
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
              child: CarFavoriteCard(
                  state: state,
                  token: tokenProvider.token!,
                  lang: languageProvider.locale.languageCode),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: colorEmber,
            ),
          );
        },
      ),
    );
  }
}
