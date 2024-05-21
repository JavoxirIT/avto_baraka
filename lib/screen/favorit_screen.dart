import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:avto_baraka/widgets/title.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  bool isSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: paddingLayout(
          Column(
            children: [
              title(context, S.of(context).tanlanganlar),
              const SizedBox(
                height: 14.0,
              ),
              // Expanded(
              //   child: carCard(favoritCarList),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
