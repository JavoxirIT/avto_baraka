import 'package:avto_baraka/api/models/districs_model.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

import '../form_step_title.dart';

class District extends StatefulWidget {
  const District({
    super.key,
    required this.districts,
    required this.regionGroupValue,
    required this.initialDistrictsGroupValue,
    required this.onDistrictChanged,
  });

  final List<DistrictsModel> districts;
  final int regionGroupValue;
  final int initialDistrictsGroupValue;
  final ValueChanged<int> onDistrictChanged;

  @override
  DistrictState createState() => DistrictState();
}

class DistrictState extends State<District> {
  late int districtsGroupValue;

  @override
  void initState() {
    super.initState();
    districtsGroupValue = widget.initialDistrictsGroupValue;
  }

  TextStyle textNoDataStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: colorEmber,
  );

  @override
  Widget build(BuildContext context) {
    debugPrint('widget.regionGroupValue: ${widget.regionGroupValue}');
    debugPrint('widget.districts: ${widget.districts}');

    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );
    return widget.districts.isEmpty || widget.regionGroupValue < 0
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Text(
                S.of(context).avvalViloyatniTanlang,
                style: textNoDataStyle,
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              formStepsTitle(S.of(context).tumanlar, context),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  // debugPrint('widget.districts: ${widget.districts}');

                  // final element = widget.districts
                  //     .where((i) => i.regionId == widget.regionGroupValue)
                  //     .toList();

                  return Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: widget.districts.length,
                      itemBuilder: (context, index) {
                        final el = widget.districts[index];
                        return Card(
                          shape: shape,
                          elevation: 0,
                          color: cardBlackColor,
                          child: RadioListTile(
                            tileColor: districtsGroupValue == el.id
                                ? unselectedItemColor
                                : null,
                            shape: shape,
                            contentPadding: contentPadding,
                            controlAffinity: ListTileControlAffinity.trailing,
                            // splashRadius: 3.0,
                            activeColor: colorWhite,
                            title: Text(
                              el.name,
                              style: TextStyle(color: colorWhite),
                            ),
                            value: el.id,
                            groupValue: districtsGroupValue,
                            onChanged: (value) {
                              setState(() {
                                districtsGroupValue = value!;
                              });
                              widget.onDistrictChanged(districtsGroupValue);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
  }
}
