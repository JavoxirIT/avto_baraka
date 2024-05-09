import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/utill/credit.dart';
import 'package:avto_baraka/widgets/flutterShowToast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreditFirstView extends StatefulWidget {
  const CreditFirstView({Key? key}) : super(key: key);

  @override
  CreditFirstViewState createState() => CreditFirstViewState();
}

class CreditFirstViewState extends State<CreditFirstView> {
  bool isLastStep = false;
  int bankGroupValue = -1;
  bool isDisabled = true;
  Map<String, dynamic> dataOneBank = {};

  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).kreditKalkulatori.toUpperCase()),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
          itemCount: credit.length,
          itemBuilder: (context, index) {
            final creditItem = credit[index];
            TextStyle textStyle = TextStyle(
              color: bankGroupValue == creditItem['id']
                  ? textColorWhite
                  : Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            );

            return Card(
              child: RadioListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Wrap(
                      children: [
                        Image.asset(creditItem['img']),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          creditItem['bankName'],
                          style: textStyle,
                        )
                      ],
                    ),
                    Text(
                      '${creditItem['percent'].toString()}%',
                      style: textStyle,
                    ),
                  ],
                ),
                shape: shape,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  setState(() {
                    bankGroupValue = value;
                    isDisabled = false;
                    if (bankGroupValue == creditItem['id']) {
                      dataOneBank = creditItem;
                    }
                  });
                },
                value: creditItem['id'],
                groupValue: bankGroupValue,
                fillColor: MaterialStateColor.resolveWith((states) =>
                    bankGroupValue == creditItem['id']
                        ? textColorWhite
                        : Colors.black),
                tileColor:
                    bankGroupValue == creditItem['id'] ? splashColor : null,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgrounColorWhite,
          boxShadow: [
            BoxShadow(
              color: backgnColStepCard,
              blurRadius: 4,
              offset: const Offset(0, 0), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 0.0, left: 15.0, right: 15.0),
        child: ElevatedButton(
          style: elevatedButton,
          onPressed: () {
            !isDisabled
                ? Navigator.of(context).pushNamed(RouteName.creditSecondView,
                    arguments: dataOneBank)
                : null;
            if (isDisabled) {
              flutterShowToast(S.of(context).avvalBankniTanlang);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).oldinga),
              const SizedBox(width: 15.0),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
