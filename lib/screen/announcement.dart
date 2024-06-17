// ignore_for_file: use_build_context_synchronously

import 'package:avto_baraka/api/service/payments__service.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:provider/provider.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  // response status text
  String responseStatusText = "";
  //

  var controller = Get.put(MainStateControllee());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  List<RegionModel>? region;
  List<DistrictsModel>? districts;
  List<CarCategoryModels> categoryList = [];
  List<CarBrandsModels> carBrandList = [];
  List<CarModels> carModelList = [];
  List<CarBodyModels> carBodyList = [];
  List<CarTransmissionModels> carTransmissionList = [];
  List<CarFuelsModels> carFuelsList = [];
  List<CarPullingSideModels> carPullingSideList = [];
  List<CarPaintConditionModel> carPaintConditionList = [];
  List<ValyutaModels> valyutaList = [];
  int currentStep = 0;
  String? description;
  String _mapData = "";
  //
  int? oncheckId;

// camera
  // String base64String = '';
  // File? _studentImg;

// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::
  final ImagePicker imagePicker = ImagePicker();
  late List<XFile> imageFileList = [];

// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::
  bool creditCheckBoxValue = false;
  // form item value
  int _credit = 0;
  final _carYearValue = TextEditingController();
  final _bodyType = TextEditingController();
  final _engineValue = TextEditingController();
  final _transmissionValue = TextEditingController();
  final _paintConditionValue = TextEditingController();
  final _pullingSideValue = TextEditingController();
  final _mileageValue = TextEditingController();
  final _descriptionValue = TextEditingController();
  final _typeOfFuelValue = TextEditingController();
  final _carPosition = TextEditingController();
  final _price = TextEditingController();
  final _valyuta = TextEditingController();

  // step radio group
  int regionGroupValue = -1;
  int districtsGroupValue = -1;
  int carTypeGroupValue = -1;
  int carBrandGroupValue = -1;
  int carModelGroupValue = -1;

  @override
  void dispose() {
    _carYearValue.dispose();
    _bodyType.dispose();
    _engineValue.dispose();
    _transmissionValue.dispose();
    _pullingSideValue.dispose();
    _mileageValue.dispose();
    _descriptionValue.dispose();
    _typeOfFuelValue.dispose();
    _carPosition.dispose();
    _price.dispose();
    _valyuta.dispose();
    super.dispose();
  }

// location
  double lat = 0;
  double long = 0;
  final MapController _mapController = MapController();
  LatLng _currentPosition = const LatLng(0, 0);
  Position? _currentLocation;
  bool servicePosition = false;
  late LocationPermission permission;
  String? escription;
  Future<void> _getCurrentLocation() async {
    servicePosition = await Geolocator.isLocationServiceEnabled();
    if (!servicePosition) {
      debugPrint('Сервис не работает!!!');
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

      setState(() {
        _currentPosition = LatLng(value.latitude, value.longitude);
        _mapController.move(_currentPosition, 16.0);
      });
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
        _mapData = " ${place.locality}, ${place.thoroughfare}";
      });
    } catch (e) {
      debugPrint('_getAddressFromCoordinates error: $e');
    }
  }

  @override
  initState() {
    super.initState();

    loadAllData();
  }

  onBackForm() {
    setState(() {
      currentStep = 0;
    });
  }

  TextStyle textNoDataStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: iconSelectedColor,
  );
  TextStyle fonmDataTextStyle = const TextStyle(fontSize: 12.0);
  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );

    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).elonJoylash)),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: iconSelectedColor),
          ),
          child: Form(
            key: formKey,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                steps: getSteps(context, shape, contentPadding),
                currentStep: currentStep,
                // onStepTapped: onStepTapped,
                controlsBuilder: (context, details) {
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: stepsNavigation(
          context,
          currentStep,
          onStepCansel,
          onStepContinue,
          region,
          districts,
          getSteps,
        ));
  }

  List<Step> getSteps(
    BuildContext context, [
    RoundedRectangleBorder? shape,
    EdgeInsets? contentPadding,
  ]) {
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
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final type = categoryList[index];
                  return Card(
                    shape: shape,
                    elevation: 0,
                    color: backgnColStepCard,
                    child: RadioListTile(
                      tileColor:
                          carTypeGroupValue == type.id ? splashColor : null,
                      shape: shape,
                      contentPadding: contentPadding,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Row(children: [
                        Image.network(Config.imageUrl! + type.icon,
                            height: 34.0),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          type.name,
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                      ]),
                      value: type.id,
                      groupValue: carTypeGroupValue,
                      onChanged: (value) async {
                        setState(() {
                          carTypeGroupValue = value!;
                        });
                        carBrandList =
                            await CarService().getBrands(carTypeGroupValue);
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
        content: carBrandList.isEmpty
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
                      return Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: carBrandList.length,
                          itemBuilder: (context, index) {
                            final brand = carBrandList[index];
                            return Card(
                              shape: shape,
                              elevation: 0,
                              color: backgnColStepCard,
                              child: RadioListTile(
                                shape: shape,
                                tileColor: carBrandGroupValue == brand.id
                                    ? splashColor
                                    : null,
                                contentPadding: contentPadding,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Row(children: [
                                  CircleAvatar(
                                    backgroundColor: backgrounColorWhite,
                                    child: Image.network(
                                      Config.imageUrl! + brand.logo,
                                      height: 24.0,
                                      width: 24.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    brand.nameRu,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                                value: brand.id,
                                groupValue: carBrandGroupValue,
                                onChanged: (value) async {
                                  setState(() {
                                    carBrandGroupValue = value!;
                                  });
                                  carModelList = await CarService().getCarModel(
                                      carTypeGroupValue, carBrandGroupValue);
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
              return carModelList.isEmpty
                  ? const SizedBox(
                      child: Text("Avval avtotransport turini tanlang"),
                    )
                  : Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: carModelList.length,
                        itemBuilder: (context, index) {
                          final names = carModelList[index];
                          return Card(
                            shape: shape,
                            elevation: 0,
                            color: backgnColStepCard,
                            child: RadioListTile(
                              shape: shape,
                              tileColor: carModelGroupValue == names.id
                                  ? splashColor
                                  : null,
                              contentPadding: contentPadding,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Row(children: [
                                CircleAvatar(
                                  backgroundColor: backgrounColorWhite,
                                  child: Image.network(
                                    Config.imageUrl! + names.img,
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  names.nameRu,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              value: names.id,
                              groupValue: carModelGroupValue,
                              onChanged: (value) {
                                setState(() {
                                  carModelGroupValue = value!;
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
      // input and drowdown
      Step(
        isActive: currentStep >= 5,
        title: const Text(""),
        content: Column(
          children: [
            // formStepsTitle("Batafsil malumotlari", context),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 0,
              ),
              children: [
                // год автомобиля
                TextFormField(
                  maxLength: 4,
                  controller: _carYearValue,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      validate(value, S.of(context).abtomashinaYiliniKiriting),
                  decoration: InputDecoration(
                    focusedBorder: formInputBorder,
                    enabledBorder: formInputBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text(
                      S.of(context).ishlabChiqarilganYili,
                      // style: formLabelTextStyle,
                    ),
                    // suffixIcon: GestureDetector(
                    //   child: const Icon(Icons.date_range),
                    //   onTap: () {
                    //     showCupModalPopup(
                    //       CupertinoDatePicker(
                    //         initialDateTime: date,
                    //         mode: CupertinoDatePickerMode.monthYear,
                    //         onDateTimeChanged: (DateTime newDate) {
                    //           setState(() {
                    //             date = newDate;
                    //             _dateValue.text =
                    //                 DateFormat.yMd().format(newDate);
                    //           });
                    //         },
                    //       ),
                    //       context,
                    //     );
                    //   },
                    // ),
                  ),
                ),
                // кузов
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  validator: (value) =>
                      validate(value, S.of(context).kuzovTurinitanlang),
                  items: carBodyList
                      .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.nameRu,
                            style: fonmDataTextStyle,
                          )))
                      .toList(),
                  onChanged: (value) {
                    _bodyType.text = value.toString();
                  },
                  decoration:
                      announcementInputDecoration(S.of(context).kuzovTuri),
                ),
                // объём двигателя
                TextFormField(
                  decoration:
                      announcementInputDecoration(S.of(context).dvigatelHajmi),
                  keyboardType: TextInputType.number,
                  controller: _engineValue,
                  validator: (value) =>
                      validate(value, S.of(context).dvigatelHajminiKiriting),
                ),
                // carTransmissionList
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: carTransmissionList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              e.nameRu,
                              style: fonmDataTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _transmissionValue.text = value.toString();
                  },
                  decoration: announcementInputDecoration(
                    S.of(context).uzatishQutisi,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).uzatishQutisiniTanlang),
                ),
                // paintCondition
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: carPaintConditionList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              e.nameRu,
                              style: fonmDataTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _paintConditionValue.text = value.toString();
                  },
                  decoration: announcementInputDecoration(
                    S.of(context).boyoqHolati,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).boyoqHolatiniKiriting),
                ),
                // pullingSide
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: carPullingSideList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              e.nameRu,
                              style: fonmDataTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _pullingSideValue.text = value.toString();
                  },
                  decoration: announcementInputDecoration(
                    S.of(context).tortuvchiTomon,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).tortishTomoniniTanlang),
                ),
                // carFuelsList
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: carFuelsList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              e.nameRu,
                              style: fonmDataTextStyle,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _typeOfFuelValue.text = value.toString();
                  },
                  decoration: announcementInputDecoration(
                    S.of(context).yoqilgiTuri,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).yoqilgiTuriniTanlang),
                ),
                // _carPosition
                TextFormField(
                  controller: _carPosition,
                  keyboardType: TextInputType.streetAddress,
                  decoration: announcementInputDecoration(
                    S.of(context).versiyasiniTanlang,
                  ),
                  validator: (value) => validate(
                    value,
                    S.of(context).versiyasiniTanlang,
                  ),
                ),
                //  NARXI
                TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: announcementInputDecoration(
                    S.of(context).narxi,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).narxiniKiriting),
                  maxLength: 12,
                ),
                // VALYUTA
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  alignment: AlignmentDirectional.centerEnd,
                  items: valyutaList
                      .map(
                        (valyuta) => DropdownMenuItem(
                          value: valyuta.id,
                          child: Text(
                            valyuta.nameru,
                            style: fonmDataTextStyle,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _valyuta.text = value.toString();
                  },
                  decoration: announcementInputDecoration(
                    S.of(context).valyuta,
                  ),
                  validator: (value) =>
                      validate(value, S.of(context).valyutaniTanlang),
                ),
              ],
            ),
            // ПРОБЕГ
            TextFormField(
              controller: _mileageValue,
              keyboardType: TextInputType.number,
              decoration: announcementInputDecoration(
                S.of(context).yurganMasofasi,
              ),
              maxLength: 7,
              validator: (value) =>
                  validate(value, S.of(context).yurganMasofaniKiriting),
            ),
            const SizedBox(
              height: 14.0,
            ),
            // Description
            TextFormField(
              controller: _descriptionValue,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              decoration:
                  announcementInputDecoration(S.of(context).qoshimchaMalumot),
              validator: (value) =>
                  validate(value, S.of(context).qoshimchaMalumotniKriting),
              maxLength: 100,
            ),
            //
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              child: Row(
                children: [
                  Checkbox(
                    value: creditCheckBoxValue,
                    onChanged: (value) {
                      setState(() {
                        creditCheckBoxValue = value!;
                        if (value) {
                          _credit = 1;
                        } else {
                          _credit = 0;
                        }
                      });
                    },
                  ),
                  Text(S.of(context).kriditgaBeriladimi),
                ],
              ),
            ),
            // Karta
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(S.of(context).xaritadaJoylashuvi),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).geolokatsiyaniYoqish,
                    style: TextStyle(fontSize: 10.0, color: colorRed),
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

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(_mapData),
            ),
            // WIDGETS MAP GEOLOCATION CHANGE
            SizedBox(
              height: 400.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border:
                            Border.all(width: 1.0, color: iconSelectedColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _currentPosition,
                            initialZoom: 16.0,
                            onTap: (tapPosition, point) => {
                              setState(() {
                                _currentPosition = point;
                              })
                            },
                            onMapReady: () {
                              _mapController.mapEventStream
                                  .listen((MapEvent event) {
                                if (event is MapEventMoveEnd) {
                                  setState(() {
                                    _currentPosition =
                                        _mapController.camera.center;
                                  });
                                }
                              });
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: _currentPosition,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: iconSelectedColor,
                                    size: 46.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // foto
      Step(
        isActive: currentStep >= 6,
        title: const Text(""),
        content: SingleChildScrollView(
          child: Column(
            children: [
              formStepsTitle(S.of(context).rasmlarniYuklang, context),
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
                            text: S.of(context).gallereyadanTanlash,
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(FontAwesomeIcons.camera, size: 14.0),
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).rasimgaOlish,
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
      // Tarif step
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

  // void onStepTapped(step) {
  //   setState(() {
  //     currentStep = step;
  //   });
  // }

  void onStepCansel() {
    if (currentStep == 0) {
      return;
    } else {
      setState(() => currentStep -= 1);
      // Navigator.of(context).pop();
    }
  }

  void onStepContinue() {
    if (currentStep == 5) {
      if (formKey.currentState!.validate() &&
          _currentPosition.latitude != 0 &&
          _currentPosition.longitude != 0) {
        setState(() {
          currentStep += 1;
        });
      } else {
        showModalBottom(
            context,
            190.0,
            [
              Text(
                S.of(context).iltimos.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                S.of(context).xaritadanJoylashuvniTanlang,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: () async {
                  _getCurrentLocation();
                  await _getAddressFromCoordinates();
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  S.of(context).avtomatikTanlash,
                ),
              )
            ],
            false,
            false);
      }
    } else if (currentStep == 6) {
      final providerLanguage =
          Provider.of<LocalProvider>(context, listen: false);
      sendData(providerLanguage.locale.languageCode);
    } else {
      setState(() {
        currentStep = (currentStep + 1) % getSteps(context).length;
      });
    }
  }

// ::::::::::ПОЛУЧЕНИЕ ДАННЫХ ИЗ :::::::::::::::::::
  Future<void> loadAllData() async {
    region = await RegionService().getRegions();
    districts = await DistrictsService().getDistricts();
    categoryList = await CarService().carCategoryLoad();
    carBodyList = await CarService().getCarBody();
    carTransmissionList = await CarService().getCarTransmision();
    carFuelsList = await CarService().getCarTypeFuels();
    carPullingSideList = await CarService().getCarPullingSide();
    carPaintConditionList = await CarService().getCarPointCondition();
    valyutaList = await ValyutaService().getValyuta();
    if (mounted) {
      setState(() {});
    }
  }

  sendData(lang) async {
    // debugPrint('Data Send');

    responseStatusText = await ListingService.servive.postAutoData(
      {
        "region_id": regionGroupValue,
        "district_id": districtsGroupValue,
        "car_type_id": carTypeGroupValue,
        "car_brand_id": carBrandGroupValue,
        "car_model_id": carModelGroupValue,
        "body_type_id": _bodyType.text,
        "year": _carYearValue.text,
        "engine": _engineValue.text,
        "transmission_id": _transmissionValue.text,
        "pulling_side_id": _pullingSideValue.text,
        "mileage": _mileageValue.text,
        "description": _descriptionValue.text,
        "type_of_fuel_id": _typeOfFuelValue.text,
        "car_position": _carPosition.text,
        "lat": _currentPosition.latitude,
        "long": _currentPosition.longitude,
        "price": _price.text,
        "valyuta_id": _valyuta.text,
        "credit": _credit,
        "paint_condition": _paintConditionValue.text
      },
      imageFileList,
    );
    // debugPrint('responseStatusText: $responseStatusText');

    if (responseStatusText == "Unpaid") {
      description = await PaymentsService().paymentDesc(lang);
      dialogBuilder(
        context,
        S.of(context).elonSaqlandi,
        Text(
          description ?? S.of(context).tizimdanTolFoy,
        ),
        [
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).yangiElonJoylash),
              onPressed: () {
                Navigator.of(context).pop();
                onBackForm();
              }),
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).amalgaOshirish),
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteName.firstpayView)),
        ],
      );
    } else if (responseStatusText == "success") {
      dialogBuilder(
        context,
        S.of(context).elonSaqlandi,
        Text(S
            .of(context)
            .elonQabulQilindiAdministratorlarTekshirganidanSongTizimgaJoylanadi),
        [
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).elonJoylash),
              onPressed: () {
                Navigator.of(context).pop();
                onBackForm();
              }),
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).elonlarOynasi),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.mainScreen, (route) => false)),
        ],
      );
    }
  }
}
