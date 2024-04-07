import 'package:avto_baraka/api/models/districs_model.dart';
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/regions_repository/districts_service.dart';
import 'package:avto_baraka/api/regions_repository/region_service.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/auto_name.dart';
import 'package:avto_baraka/utill/car_brand.dart';
import 'package:avto_baraka/utill/type_of_transport.dart';
import 'package:avto_baraka/widgets/announcement/form_build_complate.dart';
import 'package:avto_baraka/widgets/announcement/form_step_title.dart';
import 'package:avto_baraka/widgets/announcement/step_navigation.dart';
import 'package:avto_baraka/widgets/show_modal_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  List<RegionModel>? region;
  List<DistrictsModel>? districts;
  bool isComplate = false;
  int currentStep = 0;

  //
  final _dateValue = TextEditingController();

  // step radio group
  int regionGroupValue = -1;
  int districtsGroupValue = -1;
  int carTypeGroupValue = -1;
  int carBrandGroupValue = -1;
  int carNameGroupValue = -1;
  int carPositionNameGroupValue = -1;

  @override
  void initState() {
    loadRegion();
    super.initState();
  }

  onBackForm() {
    setState(() {
      isComplate = false;
      currentStep = 0;
    });
  }

  TextStyle textNoDataStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: iconSelectedColor,
  );
  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );

    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);

    return Scaffold(
        appBar: AppBar(
          title: Text(!isComplate ? "E’lon joylash" : "Bosh sahifa"),
        ),
        body: isComplate
            ? fomBuildComplate(onBackForm)
            : Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: iconSelectedColor)),
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    child: Stepper(
                      elevation: 0,
                      type: StepperType.horizontal,
                      steps: getSteps(context, shape, contentPadding),
                      currentStep: currentStep,
                      onStepTapped: onStepTapped,
                      controlsBuilder: (context, details) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: !isComplate
            ? stepsNavigation(context, currentStep, onStepCansel,
                onStepContinue, region, districts, getSteps)
            : null);
  }

  List<Step> getSteps(BuildContext context,
      [RoundedRectangleBorder? shape, EdgeInsets? contentPadding]) {
    return [
      Step(
        isActive: currentStep >= 0,
        title: const Text(""),
        content: Column(
          children: [
            formStepsTitle("Viloyatni tanlang", context),
            region == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: region!.length,
                          itemBuilder: (context, i) {
                            final el = region![i];
                            return Card(
                              shape: shape,
                              semanticContainer: true,
                              elevation: 0,
                              color: backgnColStepCard,
                              child: RadioListTile(
                                tileColor: regionGroupValue == el.id
                                    ? splashColor
                                    : null,
                                shape: shape,
                                contentPadding: contentPadding,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                // splashRadius: 3.0,
                                title: Text(
                                  el.nameUz,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: el.id,
                                groupValue: regionGroupValue,
                                onChanged: (value) async {
                                  setState(() {
                                    regionGroupValue = value!;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
      // Tumanlar
      Step(
        isActive: currentStep >= 1,
        title: const Text(""),
        content: districts == null || regionGroupValue < 0
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Text(
                    "Avval viloyatni tanlang",
                    style: textNoDataStyle,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  formStepsTitle('Tumanlar', context),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      final element = districts!
                          .where((i) => i.regionId == regionGroupValue)
                          .toList();

                      setState(() {});
                      return Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: element.length,
                          itemBuilder: (context, index) {
                            final el = element[index];
                            return Card(
                              shape: shape,
                              elevation: 0,
                              color: backgnColStepCard,
                              child: RadioListTile(
                                tileColor: districtsGroupValue == el.id
                                    ? splashColor
                                    : null,
                                shape: shape,
                                contentPadding: contentPadding,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                // splashRadius: 3.0,
                                title: Text(
                                  el.nameUz,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: el.id,
                                groupValue: districtsGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    districtsGroupValue = value!;
                                    debugPrint('${value}');
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
      // Texnika turi
      Step(
        isActive: currentStep >= 2,
        title: const Text(""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formStepsTitle("Texnika turini tanlang", context),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: typeOfTransport.length,
                itemBuilder: (context, index) {
                  final type = typeOfTransport[index];
                  return Card(
                    shape: shape,
                    elevation: 0,
                    color: backgnColStepCard,
                    child: RadioListTile(
                      tileColor:
                          carTypeGroupValue == type['id'] ? splashColor : null,
                      shape: shape,
                      contentPadding: contentPadding,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Row(children: [
                        Image.asset(type['image'], height: 34.0),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          type['name'],
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                      ]),
                      value: type["id"],
                      groupValue: carTypeGroupValue,
                      onChanged: (value) {
                        setState(() {
                          carTypeGroupValue = value!;
                          debugPrint('${value}');
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
      // Brendni tanlang
      Step(
        isActive: currentStep >= 3,
        title: const Text(""),
        content: carTypeGroupValue < 0
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Text(
                    "Avval texnika turini tanlang",
                    style: textNoDataStyle,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  formStepsTitle("Brendni tanlang", context),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      final brands = carBrand
                          .where((i) => i['typeId'] == carTypeGroupValue)
                          .toList();

                      setState(() {});
                      return Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: brands.length,
                          itemBuilder: (context, index) {
                            final brand = brands[index];
                            return Card(
                              shape: shape,
                              elevation: 0,
                              color: backgnColStepCard,
                              child: RadioListTile(
                                shape: shape,
                                tileColor: carBrandGroupValue == brand['id']
                                    ? splashColor
                                    : null,
                                contentPadding: contentPadding,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Row(children: [
                                  CircleAvatar(
                                    backgroundColor: backgrounColorWhite,
                                    child: Image.asset(brand['image'],
                                        height: 24.0, width: 24.0),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    brand['name'],
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                                value: brand["id"],
                                groupValue: carBrandGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    carBrandGroupValue = value!;
                                    debugPrint('$value');
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
      // Markani tanlang
      Step(
        isActive: currentStep >= 4,
        title: const Text(""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formStepsTitle("Markani tanlang", context),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              final name = autoName
                  .where((i) => i['brandId'] == carBrandGroupValue)
                  .toList();

              setState(() {});

              return Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    final names = name[index];
                    return Card(
                      shape: shape,
                      elevation: 0,
                      color: backgnColStepCard,
                      child: RadioListTile(
                        shape: shape,
                        tileColor: carNameGroupValue == names['id']
                            ? splashColor
                            : null,
                        contentPadding: contentPadding,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                          names['name'],
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        value: names["id"],
                        groupValue: carNameGroupValue,
                        onChanged: (value) {
                          setState(() {
                            carNameGroupValue = value!;
                            debugPrint('$value');
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      // Versiyasini tanlang
      Step(
        isActive: currentStep >= 5,
        title: const Text(""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formStepsTitle("Versiyasini tanlang", context),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: autoPosition.length,
                itemBuilder: (context, index) {
                  final names = autoPosition[index];
                  return Card(
                    shape: shape,
                    elevation: 0,
                    color: backgnColStepCard,
                    child: RadioListTile(
                      shape: shape,
                      tileColor: carPositionNameGroupValue == names['id']
                          ? splashColor
                          : null,
                      contentPadding: contentPadding,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        names['name'],
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      value: names["id"],
                      groupValue: carPositionNameGroupValue,
                      onChanged: (value) {
                        setState(() {
                          carPositionNameGroupValue = value!;
                          debugPrint('$value');
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
      Step(
        isActive: currentStep >= 6,
        title: const Text(""),
        content: Column(
          children: [
            formStepsTitle("Batafsil malumotlari", context),
            TextFormField(
              controller: _dateValue,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.date_range),
                  onTap: () {
                    showCupModalPopup(
                      CupertinoDatePicker(
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() {
                            date = newDate;
                            _dateValue.text = DateFormat.yMd().format(newDate);
                          });
                        },
                      ),
                      context,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 7,
        title: const Text(""),
        content: Column(
          children: [
            formStepsTitle("Rasmlarni yuklang", context),
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 8,
        title: const Text(""),
        content: Column(
          children: [
            formStepsTitle("Tarifni tanlang", context),
          ],
        ),
      ),
    ];
  }

  void onStepTapped(step) => setState(() {
        currentStep = step;
      });

  void onStepCansel() {
    if (currentStep == 0) {
      return;
    } else {
      setState(() => currentStep -= 1);
      // Navigator.of(context).pop();
    }
  }

  void onStepContinue() {
    final isLastSteps = currentStep == getSteps(context).length - 1;

    if (isLastSteps) {
      setState(() {
        isComplate = true;
        // Navigator.of(context).pop(false);
      });
    } else {
      currentStep += 1;
      setState(() {
        // Navigator.of(context).pop(false);
      });
    }
  }

  Future<void> loadRegion() async {
    region = await RegionService().getRegions();
    districts = await DistrictsService().getDistricts();
    setState(() {});
  }
}
