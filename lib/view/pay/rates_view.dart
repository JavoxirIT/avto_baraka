import 'package:avto_baraka/view/pay/rates_card.dart';
import 'package:flutter/material.dart';
import 'package:avto_baraka/api/models/rates_models.dart';
import 'package:avto_baraka/api/service/payments__service.dart';

import '../../generated/l10n.dart';

class RatesView extends StatefulWidget {
  const RatesView({Key? key}) : super(key: key);

  @override
  RatesViewState createState() => RatesViewState();
}

class RatesViewState extends State<RatesView> {
  List<RatesModels> listRates = [];
  int listingId = -1;

  @override
  void initState() {
    getlocal();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null) {
      Map<String, dynamic> argument = setting.arguments as Map<String, dynamic>;
      listingId = argument['listingId'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tariflar),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listRates.length,
                itemBuilder: (context, i) {
                  final el = listRates[i];
                  // bool isBool = oncheckId == el.id;
                  return RatesCard(
                    id: el.id,
                    isBool: true,
                    name: el.name,
                    price: el.price,
                    topDays: el.topDays,
                    listingId: listingId
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void getlocal() async {
    listRates = await PaymentsService.ps.getRates();
    setState(() {});
  }
}






//  Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6.0),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           oncheckId = el.id;
//                         });
//                       },
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(15.0),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: oncheckId == el.id
//                               ? Colors.white
//                               : Color(int.parse("0xFFD0ECE7")),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(15.0),
//                           ),
//                           border: oncheckId == el.id
//                               ? Border.all(width: 2.0, color: colorRed)
//                               : null,
//                         ),
//                         padding: const EdgeInsets.all(15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   el.name,
//                                   style: const TextStyle(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0, vertical: 3.0),
//                                   decoration: const BoxDecoration(
//                                     color: Color.fromARGB(255, 255, 255, 255),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(15.0),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     '${el.price} s',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 18.0,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(S
//                                 .of(context)
//                                 .topdaJoylashuvDaysKun(el.topDays.toString()))
//                             // Text(el["pullUp"]),
//                             // Text(el["inRecommended"]),
//                             // Text(el["shelfLife"]),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );