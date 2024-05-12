import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:avto_baraka/utill/mack/bank_card_mack.dart';
import 'package:avto_baraka/utill/mack/bank_card_term.dart';
import 'package:avto_baraka/utill/validation/phone_validator.dart';
import 'package:flutter/material.dart';

class FirstPayFormView extends StatefulWidget {
  const FirstPayFormView({Key? key}) : super(key: key);

  @override
  FirstPayFormViewPayState createState() => FirstPayFormViewPayState();
}

class FirstPayFormViewPayState extends State<FirstPayFormView> {
  final formKey = GlobalKey<FormState>();
  final _bankCard = TextEditingController();
  final _pay = TextEditingController();
  final _cardTerm = TextEditingController();

  @override
  void dispose() {
    _bankCard.dispose();
    _pay.dispose();
    _cardTerm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800);
    TextStyle inputTextStyle =
        TextStyle(fontSize: 18.0, color: unselectedItemColor);
    OutlineInputBorder focusBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: unselectedItemColor, width: 1),
    );

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: unselectedItemColor, width: 3.0),
    );

    EdgeInsets padding = const EdgeInsets.all(0);
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.always;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: 35.0, right: 35.0, bottom: 50.0),
                child: Center(
                  child: Text(
                    "Tizimdan to’liq foydalanish uchun 12 500 so’m miqdorida to’lov qilishingiz lozim bo’ladi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF008080),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              TextFormField(
                inputFormatters: [bankCardMask],
                controller: _bankCard,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text(
                    "PK raqami",
                    style: textStyle,
                  ),
                  hintText: "_ _ _ _    _ _ _ _    _ _ _ _    _ _ _ _",
                  focusedBorder: focusBorder,
                  enabledBorder: enabledBorder,
                  contentPadding: padding,
                  floatingLabelBehavior: floatingLabelBehavior,
                ),
                style: inputTextStyle,
                textAlign: TextAlign.center,
                validator: (value) => phoneValidator(value!),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _pay,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text(
                          "Summa",
                          style: textStyle,
                        ),
                        hintText: "10000",
                        focusedBorder: focusBorder,
                        enabledBorder: enabledBorder,
                        contentPadding: padding,
                        floatingLabelBehavior: floatingLabelBehavior,
                      ),
                      style: inputTextStyle,
                      textAlign: TextAlign.center,
                      validator: (value) => phoneValidator(value!),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [bankCardTerm],
                      controller: _cardTerm,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "PK amal qilish muddati",
                          style: textStyle,
                        ),
                        focusedBorder: focusBorder,
                        enabledBorder: enabledBorder,
                        contentPadding: padding,
                        floatingLabelBehavior: floatingLabelBehavior,
                      ),
                      style: inputTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 30.0),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Bajarish"),
                  style: elevatedButtonMap,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
