import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:avto_baraka/api/models/districs_model.dart';
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/regions_repository/districts_service.dart';
import 'package:avto_baraka/api/regions_repository/region_service.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/state/main_state_controller.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevate_btn_cam_gall.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:avto_baraka/style/location_button.dart';
import 'package:avto_baraka/style/outline_input_border.dart';
import 'package:avto_baraka/utill/ad_rates.dart';
import 'package:avto_baraka/utill/auto_name.dart';
import 'package:avto_baraka/utill/body_type.dart';
import 'package:avto_baraka/utill/car_brand.dart';
import 'package:avto_baraka/utill/engine.dart';
import 'package:avto_baraka/utill/paint_condition.dart';
import 'package:avto_baraka/utill/pulling_side.dart';
import 'package:avto_baraka/utill/transmission.dart';
import 'package:avto_baraka/utill/type_of_fuel.dart';
import 'package:avto_baraka/utill/type_of_transport.dart';
import 'package:avto_baraka/widgets/announcement/form_build_complate.dart';
import 'package:avto_baraka/widgets/announcement/form_step_title.dart';
import 'package:avto_baraka/widgets/announcement/step_navigation.dart';
import 'package:avto_baraka/widgets/camera.dart';
import 'package:avto_baraka/widgets/show_modal_date.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  late double lat;
  late double long;
  var controller = Get.put(MainStateControllee());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  List<RegionModel>? region;
  List<DistrictsModel>? districts;
  bool isComplate = false;
  int currentStep = 0;

  //
  int? oncheckId;

// camera
  // String base64String = '';
  // File? _studentImg;

// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::
  final ImagePicker imagePicker = ImagePicker();
  late List<XFile> imageFileList = [];
// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::

  // form item value
  final _dateValue = TextEditingController();
  final _bodyType = TextEditingController();
  final _engineValue = TextEditingController();
  final _transmissionValue = TextEditingController();
  final _paintConditionValue = TextEditingController();
  final _pullingSideValue = TextEditingController();
  final _mileageValue = TextEditingController();
  final _descriptionValue = TextEditingController();
  final _mapData = TextEditingController();
  final MultiSelectController _typeOfFuelValue = MultiSelectController();
  // step radio group
  int regionGroupValue = -1;
  int districtsGroupValue = -1;
  int carTypeGroupValue = -1;
  int carBrandGroupValue = -1;
  int carNameGroupValue = -1;
  int carPositionNameGroupValue = -1;

  List<String> selected = [];

  @override
  void dispose() {
    _dateValue.dispose();
    _bodyType.dispose();
    _engineValue.dispose();
    _transmissionValue.dispose();
    _pullingSideValue.dispose();
    _mileageValue.dispose();
    _descriptionValue.dispose();
    _mapData.dispose();
    super.dispose();
  }

  Position? _currentLocation;
  bool servicePosition = false;
  late LocationPermission permission;

  Future<void> _getCurrentLocation() async {
    servicePosition = await Geolocator.isLocationServiceEnabled();
    if (!servicePosition) {
      print('Сервис не работает!!!');
      // AppSettings.openAppSettings(type: AppSettingsType.location);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _currentLocation = await Geolocator.getCurrentPosition();
    Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });
    _getAddressFromCoordinates();
  }

  _getAddressFromCoordinates([lt, ln]) async {
    List<Placemark> placemarks;
    try {
      if (lt != null || ln != null) {
        placemarks = await placemarkFromCoordinates(lt, ln);
        // print('let: ${lt}, long: ${ln},');
        lat = lt;
        long = ln;
      } else {
        placemarks = await placemarkFromCoordinates(
            _currentLocation!.latitude, _currentLocation!.longitude);
      }
      Placemark place = placemarks[0];
      setState(() {
        _mapData.text = " ${place.locality}, ${place.thoroughfare}";
        // print('_currentAddress: ${place}');
      });
    } catch (e) {
      print('error: ${e}');
    }
  }

  @override
  initState() {
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
  TextStyle formLabelTextStyle = TextStyle(
      color: iconSelectedColor, fontSize: 14.0, fontWeight: FontWeight.w600);



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
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;

    return [
      // Viloyatni tanlang
      Step(
        isActive: currentStep >= 0,
        title: const Text(""),
        content: Column(
          children: [
            formStepsTitle(S.of(context).viloyatniTanlang, context),
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
            formStepsTitle(S.of(context).texnikaTuriniTanlang, context),
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
                    S.of(context).avvalTexnikaTuriniTanlang,
                    style: textNoDataStyle,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  formStepsTitle(S.of(context).brendniTanlang, context),
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
            formStepsTitle(S.of(context).markaniTanlang, context),
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
            formStepsTitle(S.of(context).versiyasiniTanlang, context),
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
      // form item
      Step(
        isActive: currentStep >= 6,
        title: const Text(""),
        content: Column(
          children: [
            // formStepsTitle("Batafsil malumotlari", context),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: (itemWidth / itemHeight),
                childAspectRatio: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 0,
                // mainAxisExtent: ,
              ),
              children: [
                TextFormField(
                  controller: _dateValue,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: formInputBorder,
                    enabledBorder: formInputBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text(
                      S.of(context).ishlabChiqarilganYili,
                      style: formLabelTextStyle,
                    ),
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
                                _dateValue.text =
                                    DateFormat.yMd().format(newDate);
                              });
                            },
                          ),
                          context,
                        );
                      },
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: bodyType
                      .map((e) => DropdownMenuItem(
                            value: e["typeId"],
                            child: Text(e['name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _bodyType.text = value.toString();
                  },
                  decoration: InputDecoration(
                    focusedBorder: formInputBorder,
                    enabledBorder: formInputBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text(
                      S.of(context).kuzovTuri,
                      style: formLabelTextStyle,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: engine
                      .map((e) => DropdownMenuItem(
                            value: e["id"],
                            child: Text(e['value']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _engineValue.text = value.toString();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: formInputBorder,
                    focusedBorder: formInputBorder,
                    label: Text(
                      S.of(context).dvigatelHajmi,
                      style: formLabelTextStyle,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: transmission
                      .map((e) => DropdownMenuItem(
                            value: e["id"],
                            child: Text(e['value']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _transmissionValue.text = value.toString();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: formInputBorder,
                    focusedBorder: formInputBorder,
                    label: Text(
                      S.of(context).uzatishQutisi,
                      style: formLabelTextStyle,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: paintCondition
                      .map((e) => DropdownMenuItem(
                            value: e["id"],
                            child: Text(e['value']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _paintConditionValue.text = value.toString();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: formInputBorder,
                    focusedBorder: formInputBorder,
                    label: Text(
                      S.of(context).boyoqHolati,
                      style: formLabelTextStyle,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: pullingSide
                      .map((e) => DropdownMenuItem(
                            value: e["id"],
                            child: Text(e['value']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _pullingSideValue.text = value.toString();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: formInputBorder,
                    focusedBorder: formInputBorder,
                    label: Text(
                      S.of(context).tortuvchiTomon,
                      style: formLabelTextStyle,
                    ),
                  ),
                )
              ],
            ),
            TextFormField(
              controller: _mileageValue,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: formInputBorder,
                enabledBorder: formInputBorder,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  S.of(context).yurganMasofasi,
                  style: formLabelTextStyle,
                ),
              ),
            ),

            const SizedBox(
              height: 14.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).yoqilgiTuri,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: iconSelectedColor),
              ),
            ),
            MultiSelectDropDown(
              inputDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: backgnColStepCard),
              ),
              maxItems: 2,
              controller: _typeOfFuelValue,
              hint: "",
              onOptionSelected: (selectedOptions) {},
              options: typeOfFuel.map((e) {
                return ValueItem(label: e['value'], value: e['id']);
              }).toList(),
              selectionType: SelectionType.multi,
              chipConfig: ChipConfig(
                wrapType: WrapType.wrap,
                backgroundColor: switchBackgrounColor,
                labelColor: Colors.black,
                radius: 10.0,
                deleteIconColor: iconSelectedColor,
              ),
              selectedOptionIcon: Icon(
                Icons.check_circle,
                color: iconSelectedColor,
              ),
              selectedOptionTextColor: iconSelectedColor,
              optionTextStyle: const TextStyle(fontSize: 14),
              // selectedOptionIcon: const Icon(Icons.check_circle),
            ),
            const SizedBox(
              height: 34.0,
            ),
            TextFormField(
              controller: _descriptionValue,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              decoration: InputDecoration(
                focusedBorder: formInputBorder,
                enabledBorder: formInputBorder,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  S.of(context).qoshimchaMalumot,
                  style: formLabelTextStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: Text(
            //     S.of(context).xaritadaJoylashuvi,
            //     style: TextStyle(
            //         fontSize: 12.0,
            //         fontWeight: FontWeight.w600,
            //         color: iconSelectedColor),
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).geolokatsiyaniYoqish,
                    style: const TextStyle(fontSize: 10.0, color: Colors.red),
                  ),
                ),
                OutlinedButton(
                  style: locationButton,
                  onPressed: () async {
                    _getCurrentLocation();
                    await _getAddressFromCoordinates();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).avtomatikTanlash,
                        // style: TextStyle(fontSize: 16.0, color: Colors.red),
                      ),
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 14.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _mapData,
                    decoration: InputDecoration(
                      focusedBorder: formInputBorder,
                      enabledBorder: formInputBorder,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text(
                        S.of(context).xaritadaJoylashuvi,
                        style: formLabelTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  style: elevatedButtonMap,
                  onPressed: () async {
                    if (permission == LocationPermission.deniedForever) {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                      'Доступ к гелокации запрещен, пожалуйста включите доступ к локации!!'),
                                  ElevatedButton(
                                    child: const Text('Открыть настройки'),
                                    onPressed: () =>
                                        AppSettings.openAppSettings(
                                            type: AppSettingsType.location),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      // Fluttertoast.showToast(
                      //   toastLength: Toast.LENGTH_LONG,
                      //   gravity: ToastGravity.SNACKBAR,
                      //   // msg: 'Click to ${goPoint.toString()}',
                      //   msg:
                      //       'Разрешения на определение местоположения навсегда запрещены. Мы не можем запросить разрешения.',
                      // );
                      return;
                    }
                    var goPoint = await showSimplePickerLocation(
                      context: context,
                      isDismissible: true,
                      title: "Lokatsiyani tanlang",
                      textConfirmPicker: "Tanlash",
                      zoomOption: const ZoomOption(initZoom: 12.0),
                      initPosition: GeoPoint(latitude: lat, longitude: long),
                      radius: 15.0,
                    );

                    if (goPoint != null) {
                      Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        // msg: 'Click to ${goPoint.toString()}',
                        msg: 'Geopozitsiya kabul kilindi',
                      );
                      _getAddressFromCoordinates(
                          goPoint.latitude, goPoint.longitude);
                    }
                  },
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),

      // foto
      Step(
        isActive: currentStep >= 7,
        title: const Text(""),
        content: SingleChildScrollView(
          child: Column(
            children: [
              formStepsTitle("Rasmlarni yuklang", context),
              const SizedBox(
                height: 23.0,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: (itemWidth / itemHeight),
                  childAspectRatio: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 0,
                  // mainAxisExtent: ,
                ),
                children: [
                  ElevatedButton(
                    style:
                        elevatedBtnCamGall(backgrounColor: elevatedButtonColor),
                    onPressed: () => selectImages(),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.file_upload,
                                size: 14.0,
                                color: elevatedButtonTextColor,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "Gallereyadan tanlash",
                            style: TextStyle(color: elevatedButtonTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: elevatedBtnCamGall(
                        backgrounColor: elevatedButtonCameraBtnColor),
                    onPressed: () {
                      dataCamera();
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(FontAwesomeIcons.camera, size: 14.0),
                            ),
                          ),
                          TextSpan(
                            text: "Rasimga olish",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 17.0,
              ),
              GridView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: (itemWidth / itemHeight),
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  // mainAxisExtent: ,
                ),
                children: imageFileList
                    .map((img) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Image.file(
                                File(img.path),
                                fit: BoxFit.cover,
                                height: 157.0,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                              top: 3.0,
                              right: 3.0,
                              child: CircleAvatar(
                                backgroundColor: colorRed,
                                radius: 15.0,
                                child: IconButton(
                                  onPressed: () => onDeleteImage(img.path),
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      
      // Tarigf step
      Step(
        isActive: currentStep >= 8,
        title: const Text(""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            formStepsTitle(S.of(context).tarifniTanlang, context),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: adRates.length,
                itemBuilder: (context, i) {
                  final el = adRates[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: InkWell(
                      onTap: () {
                        print('data: ${el["name"]}');
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
              ),
            ),
          ],
        ),
      ),
    ];
  }

//::::::::::::::::::::::::УДАЛЕНИЕ ИЗОБРАЖЕНИЯ ::::::::::::::::::::::::

  onDeleteImage(String path) {
    List<XFile> img = imageFileList.where((el) => el.path != path).toList();
    setState(() {
      imageFileList = img;
    });
  }

  // ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }

    if (kDebugMode) {
      print("Image List Length:${imageFileList.length}");
    }
    setState(() {});
  }

  // ::::::::::::::::::::::PICK IMAGE CAMERA::::::::::::::::::::::::
  void dataCamera() async {
    final camera = await availableCameras().then((value) {
      return value;
    });
    Route route = MaterialPageRoute(
      builder: (_) => CameraPage(cameras: camera),
    );
    final result = await Navigator.push(context, route);

    setState(() {
      if (result != null) {
        imageFileList.add(result);
      }
    });

    // ImagetoBase64();
  }

  // imagetoBase64() async {
  //   Read bytes from the file object
  //   Uint8List _bytes = await _studentImg!.readAsBytes();

  //   base64 encode the bytes
  //   String _base64String = base64.encode(_bytes);
  //   setState(() {
  //     base64String = _base64String;
  //     print('base64String---->: ${base64String}');
  //   });
  // }

// ::::::::::::::::STEP SETTING::::::::::::::::::::::

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

// ::::::::::ПОЛУЧЕНИЕ ДАННЫХ ИЗ API :::::::::::::::::::
  Future<void> loadRegion() async {
    region = await RegionService().getRegions();
    districts = await DistrictsService().getDistricts();
    setState(() {});
  }
}
