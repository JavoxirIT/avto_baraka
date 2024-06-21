// ignore_for_file: use_build_context_synchronously

import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/api/service/payments__service.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_1_region.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_2_district.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_3_car_type.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_4_car_brand.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_5_car_models.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_6_form_item.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_7_maps.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_8_image.dart';
import 'package:provider/provider.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  int currentStep = 0;
  String responseStatusText = "";
  String? description;
  LatLng _currentPosition = const LatLng(0, 0);
  //
  var controller = Get.put(MainStateControllee());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  List<DistrictsModel> districts = [];
  List<CarCategoryModels> categoryList = [];
  List<CarBrandsModels> carBrandList = [];
  List<CarModels> carModelList = [];

  //
  int? oncheckId;

// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::

  late List<XFile> imageFileList = [];
// ::::::::::::::::::::::GALLERY IMAGE PICKER::::::::::::::::::::::::::::

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
    _paintConditionValue.dispose();
    super.dispose();
  }

  @override
  initState() {
    loadAllData();
    super.initState();
  }

  onBackForm() {
    setState(() {
      currentStep = 0;
    });
  }

  TextStyle textNoDataStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: colorEmber,
  );
  TextStyle fonmDataTextStyle = const TextStyle(fontSize: 12.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).elonJoylash)),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: colorEmber),
            cardColor: cardBlackColor,
            canvasColor: cardBlackColor,
          ),
          child: Form(
            key: formKey,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stepper(
                margin: const EdgeInsets.all(0),
                connectorThickness: 0,
                elevation: 0,
                type: StepperType.horizontal,
                steps: getSteps(context),
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
          getSteps,
        ));
  }

  List<Step> getSteps(BuildContext context) {
    return [
      // Viloyatni tanlang
      Step(
        isActive: currentStep >= 0,
        title: const Text(""),
        content: Region(
          initiaRegionGroupValue: regionGroupValue,
          onRegionGroupValue: onRegionGroupValue,
        ),
      ),
      // Tumanlar
      Step(
        isActive: currentStep >= 1,
        title: const Text(""),
        content: District(
          districts: districts,
          regionGroupValue: regionGroupValue,
          initialDistrictsGroupValue: districtsGroupValue,
          onDistrictChanged: _onDistrictChanged,
        ),
      ),
      // Texnika turi
      Step(
        isActive: currentStep >= 2,
        title: const Text(""),
        content: CarTypeSelection(
          categoryList: categoryList,
          initialCarTypeGroupValue: carTypeGroupValue,
          onCarTypeChanged: _onCarTypeChanged,
          onCarBrandListUpdated: _onCarBrandListUpdated,
        ),
      ),
      // Brendni tanlang
      Step(
        isActive: currentStep >= 3,
        title: const Text(""),
        content: CarBrandSelection(
          carBrandList: carBrandList,
          initialCarBrandGroupValue: carBrandGroupValue,
          onCarBrandChanged: _onCarBrandChanged,
          onCarModelListUpdated: _onCarModelListUpdated,
          carTypeGroupValue: carTypeGroupValue,
        ),
      ),
      // Markani tanlang
      Step(
        isActive: currentStep >= 4,
        title: const Text(""),
        content: StepCarModels(
          initialCarModelGroupValue: carModelGroupValue,
          carModelList: carModelList,
          oncarModelGroupValue: onCarModelGroupValue,
        ),
      ),
      // input and drowdown
      Step(
        isActive: currentStep >= 5,
        title: const Text(""),
        content: FormItem(
          carYearValue: _carYearValue,
          bodyType: _bodyType,
          engineValue: _engineValue,
          transmissionValue: _transmissionValue,
          paintConditionValue: _paintConditionValue,
          pullingSideValue: _pullingSideValue,
          typeOfFuelValue: _typeOfFuelValue,
          carPosition: _carPosition,
          price: _price,
          valyuta: _valyuta,
          mileageValue: _mileageValue,
          descriptionValue: _descriptionValue,
          onCredit: onCredit,
        ),
      ),
      Step(
        isActive: currentStep >= 6,
        title: const Text(""),
        content: Maps(
          currentPosition: _currentPosition,
          onCurrentPosition: onCurrentPosition,
        ),
      ),
      // foto
      Step(
        isActive: currentStep >= 7,
        title: const Text(""),
        content: AddImage(onImageFile: onImageFile),
      ),
      // Tarif step
    ];
  }

  void _onDistrictChanged(int newValue) async {
    setState(() {
      districtsGroupValue = newValue;
    });
  }

  void _onCarTypeChanged(int newValue) {
    setState(() {
      carTypeGroupValue = newValue;
    });
  }

  void _onCarBrandListUpdated(List<CarBrandsModels> newList) {
    setState(() {
      carBrandList = newList;
    });
  }

  void _onCarBrandChanged(int newValue) {
    setState(() {
      carBrandGroupValue = newValue;
    });
  }

  void _onCarModelListUpdated(List<CarModels> newList) {
    setState(() {
      carModelList = newList;
    });
  }

  void onCarModelGroupValue(int newValue) {
    setState(() {
      carModelGroupValue = newValue;
    });
  }

  void onRegionGroupValue(int newValue) {
    setState(() {
      regionGroupValue = newValue;
      loadData(newValue);
    });
  }

  Future<void> loadData(int id) async {
    districts = await DistrictsService().getDistricts(id);
  }

  void onCurrentPosition(LatLng value) {
    setState(() {
      _currentPosition = value;
    });
  }

  void onCredit(int newValue) {
    setState(() {
      _credit = newValue;
    });
  }

  void onImageFile(List<XFile> imageList) {
    setState(() {
      imageFileList = imageList;
    });
  }

//
// ::::::::::ПОЛУЧЕНИЕ ДАННЫХ ИЗ :::::::::::::::::::
  Future<void> loadAllData() async {
    categoryList = await CarService().carCategoryLoad();
    if (mounted) {
      setState(() {});
    }
  }
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
      if (formKey.currentState!.validate()) {
        setState(() {
          currentStep += 1;
        });
      } else {
        // showModalBottom(
        //     context,
        //     190.0,
        //     [
        //       Text(
        //         S.of(context).iltimos.toUpperCase(),
        //         style: Theme.of(context).textTheme.labelLarge,
        //       ),
        //       Text(
        //         S.of(context).xaritadanJoylashuvniTanlang,
        //         style: Theme.of(context).textTheme.bodyLarge,
        //       ),
        //     ],
        //     false,
        //     false);
        return;
      }
    } else if (currentStep == 7) {
      final providerLanguage =
          Provider.of<LocalProvider>(context, listen: false);
      sendData(providerLanguage.locale.languageCode);
    } else {
      setState(() {
        currentStep = (currentStep + 1) % getSteps(context).length;
      });
    }
  }

  sendData(lang) async {
    // debugPrint(
    //   '${{
    //     "region_id": regionGroupValue,
    //     "district_id": districtsGroupValue,
    //     "car_type_id": carTypeGroupValue,
    //     "car_brand_id": carBrandGroupValue,
    //     "car_model_id": carModelGroupValue,
    //     "body_type_id": _bodyType.text,
    //     "year": _carYearValue.text,
    //     "engine": _engineValue.text,
    //     "transmission_id": _transmissionValue.text,
    //     "pulling_side_id": _pullingSideValue.text,
    //     "mileage": _mileageValue.text,
    //     "description": _descriptionValue.text,
    //     "type_of_fuel_id": _typeOfFuelValue.text,
    //     "car_position": _carPosition.text,
    //     "lat": _currentPosition.latitude,
    //     "long": _currentPosition.longitude,
    //     "price": _price.text,
    //     "valyuta_id": _valyuta.text,
    //     "credit": _credit,
    //     "paint_condition": _paintConditionValue.text,
    //     "imageFileList,": imageFileList,
    //   }}',
    // imageFileList,
    // );

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
                textStyle: Theme.of(context).textTheme.bodyLarge!,
              ),
              child: Text(
                S.of(context).yangiElonJoylash,
                style: TextStyle(
                  color: colorEmber,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onBackForm();
              }),
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              child: Text(
                S.of(context).elonlarOynasi,
                style: TextStyle(
                  color: colorEmber,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.mainScreen, (route) => false)),
        ],
      );
    }
  }
}
