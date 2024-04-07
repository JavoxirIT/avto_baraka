import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/favorit_car_card.dart';
import 'package:avto_baraka/widgets/car_card.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:avto_baraka/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  FavoritScreenState createState() => FavoritScreenState();
}

class FavoritScreenState extends State<FavoritScreen> {
  final TextStyle _textStyle =
      const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600);
  bool isSwitchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: paddingLayout(
          Column(
            children: [
              title(context, "Tanlaganlar"),
              Card(
                color: const Color.fromARGB(255, 243, 243, 243),
                elevation: 0,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tanlangan E’lonlar", style: _textStyle),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 4.0,
                        ),
                        child: FlutterSwitch(
                          width: 52.0,
                          height: 26.0,
                          valueFontSize: 0,
                          toggleSize: 20.0,
                          value: isSwitchValue,
                          borderRadius: 30.0,
                          padding: 3.0,
                          showOnOff: false,
                          activeColor: switchBackgrounColor,
                          inactiveColor: switchBackgrounColor,
                          toggleColor: iconSelectedColor,
                          onToggle: (val) {
                            setState(() {
                              isSwitchValue = val;
                            });
                          },
                        ),
                      ),
                      Text("Qidiruv so’zlari", style: _textStyle),
                    ]),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Expanded(
                child: carCard(favoritCarList),
              )
            ],
          ),
        ),
      ),
    );
  }
}
