import 'package:avto_baraka/api/models/credit_models.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:flutter/material.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  CreditScreenState createState() => CreditScreenState();
}

class CreditScreenState extends State<CreditScreen> {
  List<CreditData> list = [];
  int groupValue = -1;

  late int listingId;
  late int price;
  late String currency;

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    Map<String, dynamic> arguments = setting.arguments as Map<String, dynamic>;
    listingId = arguments["listingId"];
    price = arguments["price"];
    currency = arguments["currency"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).kreditKalkulatori.toUpperCase()),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).rasmiyIshlamaydi),
              Radio(
                value: 2,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value!;
                  });

                  postDataCredit(
                      currency: currency, bsumma: price, type: groupValue);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).rasmiyIshiBor),
              Radio(
                value: 3,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value!;
                  });
                  postDataCredit(
                      currency: currency, bsumma: price, type: groupValue);
                },
              ),
            ],
          ),
          sizedBoxH20,
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final data = list[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Table(
                    // border: TableBorder.all(
                    //   color: backgrounColor,
                    //   borderRadius: const BorderRadius.all(
                    //     Radius.circular(5.0),
                    //   ),
                    // ),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(S.of(context).kreditMuddati),
                          ),
                          TableCell(
                            child:
                                Text(data.yil.toString() + S.of(context).yil),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(S.of(context).oylarSoni),
                          ),
                          TableCell(
                            child: Text(data.data.oylarSoni.toString() +
                                S.of(context).oy),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(S.of(context).oylikTolov),
                          ),
                          TableCell(
                            child: Text(data.data.oylikTulov.toString() +
                                S.of(context).som),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(S.of(context).birinchiTolovUsd),
                          ),
                          TableCell(
                            child: Text(
                                '${data.data.summaTulovUsd.toString()} \$'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(S.of(context).birinchiTolovUzs),
                          ),
                          TableCell(
                            child: Text(
                                '${data.data.summaTulov.toString()}  ${S.of(context).som}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  Future<void> postDataCredit({
    required String? currency,
    required int? bsumma,
    required int type,
  }) async {
    list.clear();
    list = await ValyutaService().getCreditData(currency!, type, bsumma!);

    setState(() {});
  }
}
