import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

class RatesCard extends StatelessWidget {
  const RatesCard({
    Key? key,
    required this.isBool,
    required this.id,
    required this.topDays,
    required this.price,
    required this.name,
    required this.listingId,
  }) : super(key: key);

  final bool isBool;
  final int id;
  final int topDays;
  final int price;
  final String name;
  final int listingId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.firstpayView,
            arguments: {"ratesId": id, "listingId": listingId});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: textColorWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: switchBackgrounColor,
              spreadRadius: 0,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                top: -35,
                right: -20,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorEmber,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(70.0),
                        topRight: Radius.circular(10.0)),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text(S
                        .of(context)
                        .topdaJoylashuvDaysKun(topDays.toString())),
                  ),
                ],
              ),
              Positioned(
                top: 5.0,
                right: 5,
                child: Text(
                  '${price.toString()} s.',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: textColorWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
