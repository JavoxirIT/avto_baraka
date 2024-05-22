import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/ad_rates.dart';
import 'package:avto_baraka/widgets/announcement/form_step_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

tarif(context) {
  int oncheckId = -1;

  return StatefulBuilder(builder: (context, StateSetter setState) {
    return ListView.builder(
      itemCount: adRates.length,
      itemBuilder: (context, i) {
        final el = adRates[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: InkWell(
            onTap: () {
              setState(() {
                oncheckId = el['id'];
              });
            },
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: oncheckId == el['id']
                    ? Colors.white
                    : Color(int.parse(el['color'])),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                border: oncheckId == el['id']
                    ? Border.all(width: 2.0, color: colorRed)
                    : null,
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        el['name'],
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 3.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          '${el['pay']} s',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(el["topDay"]),
                  Text(el["pullUp"]),
                  Text(el["inRecommended"]),
                  Text(el["shelfLife"]),
                ],
              ),
            ),
          ),
        );
      },
    );
  });
}
