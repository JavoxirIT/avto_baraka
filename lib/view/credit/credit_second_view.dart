import 'package:avto_baraka/api/models/term_modals.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/style/outline_input_border.dart';
import 'package:avto_baraka/utill/credit_term.dart';
import 'package:avto_baraka/utill/validation/validation.dart';
import 'package:avto_baraka/widgets/flutter_show_toast.dart';
import 'package:flutter/material.dart';

class CreditSecondView extends StatefulWidget {
  const CreditSecondView({Key? key}) : super(key: key);

  @override
  CreditSecondViewState createState() => CreditSecondViewState();
}

class CreditSecondViewState extends State<CreditSecondView> {
  bool isDisabled = true;
  int termGroupValue = -1;
  List<TermModels> termList = [];

  // ignore: prefer_typing_uninitialized_variables
  late final data;

  // ::::::::::::::::Form Item Data::::::::::::::
  final formKey = GlobalKey<FormState>();
  final _summa = TextEditingController();
  final _currency = TextEditingController();
  final _initialPayment = TextEditingController();

//

  @override
  void initState() {
    loadTermData();
    super.initState();
  }

  @override
  void dispose() {
    _summa.dispose();
    _currency.dispose();
    _initialPayment.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    data = setting.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
    TextStyle formLabelTextStyle = TextStyle(
        color: iconSelectedColor, fontSize: 14.0, fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: Text('${data['bankName'].toUpperCase()}   ${data['percent']}%'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    // direction: Axis.horizontal,
                    child: TextFormField(
                      controller: _summa,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          validate(value, S.of(context).kriditSummasiniKriting),
                      decoration: InputDecoration(
                        focusedBorder: formInputBorder,
                        enabledBorder: formInputBorder,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: Text(
                          S.of(context).kreditSummasi,
                          style: formLabelTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Flexible(
                    child: DropdownButtonFormField(
                      validator: (value) =>
                          validate(value, S.of(context).valutaniTanlang),
                      isExpanded: true,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      alignment: AlignmentDirectional.centerEnd,
                      items: const [
                        DropdownMenuItem(
                          value: "1",
                          child: Text("Dollar"),
                        ),
                        DropdownMenuItem(
                          value: "2",
                          child: Text("So`m"),
                        )
                      ],
                      onChanged: (value) {
                        _currency.text = value.toString();
                      },
                      decoration: InputDecoration(
                        focusedBorder: formInputBorder,
                        enabledBorder: formInputBorder,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: Text(
                          S.of(context).valuta,
                          style: formLabelTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 17.0),
              TextFormField(
                controller: _initialPayment,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    validate(value, S.of(context).boshlangichTulovniKiriting),
                decoration: InputDecoration(
                  focusedBorder: formInputBorder,
                  enabledBorder: formInputBorder,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(
                    S.of(context).boshlangichTolov,
                    style: formLabelTextStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: termList.length,
                  itemBuilder: (context, index) {
                    final el = termList[index];
                    TextStyle textStyles = TextStyle(
                      color: termGroupValue == el.id
                          ? textColorWhite
                          : Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    );
                    return Card(
                      child: RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        // contentPadding: EdgeInsets.all(0),
                        title: Text(
                          '${el.term.toString()} ${el.termNameRu}',
                          style: textStyles,
                        ),
                        value: el.id,
                        groupValue: termGroupValue,
                        shape: shape,
                        fillColor: MaterialStateColor.resolveWith((states) =>
                            termGroupValue == el.id
                                ? textColorWhite
                                : Colors.black),
                        tileColor: termGroupValue == el.id ? splashColor : null,
                        onChanged: (value) {
                          setState(() {
                            termGroupValue = value!;
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
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
        padding: const EdgeInsets.only(bottom: 0.0, left: 25.0, right: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: elevationButtonWhite,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  Text(
                    S.of(context).orqaga,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 15.0),
                ],
              ),
            ),
            ElevatedButton(
              style: elevatedButton,
              onPressed: () {
                try {
                  if (termGroupValue < 0) {
                    flutterShowToast(S.of(context).kreditMeddatiniTanlang);
                  } else if (formKey.currentState!.validate()) {
                    if (termGroupValue > 0) {
                      var creditData = {
                        "turm": termGroupValue,
                        "summa": _summa.text,
                        "curency": _currency.text,
                        "initialPayment": _initialPayment.text,
                        ...data
                      };
                      Navigator.of(context).pushNamed(
                          RouteName.creditGraphicView,
                          arguments: creditData);
                    }
                  }
                } catch (e) {
                  debugPrint('Какая то ошибка: $e');
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
          ],
        ),
      ),
    );
  }

  loadTermData() {
    termList.clear();
    for (var elements in creditTerm) {
      termList.add(TermModels.fromMap(elements));
    }
  }
}
