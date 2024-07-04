// ignore_for_file: use_build_context_synchronously

import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_1_region.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_2_district.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_3_car_type.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_4_car_brand.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_5_car_models.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_6_form_item.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_7_maps.dart';
import 'package:avto_baraka/widgets/announcement/step_widgets/step_8_image.dart';
import 'package:avto_baraka/widgets/announcement/variables.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  AnnouncementState createState() => AnnouncementState();
}

class AnnouncementState extends State<Announcement> {
  int currentStep = 0;

  var controller = Get.put(MainStateControllee());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  //
  int? oncheckId;

  // @override
  // void dispose() {
  //   carYearValue.dispose();
  //   bodyType.dispose();
  //   engineValue.dispose();
  //   transmissionValue.dispose();
  //   pullingSideValue.dispose();
  //   mileageValue.dispose();
  //   descriptionValue.dispose();
  //   typeOfFuelValue.dispose();
  //   carPosition.dispose();
  //   price.dispose();
  //   valyuta.dispose();
  //   paintConditionValue.dispose();
  //   super.dispose();
  // }

  @override
  initState() {
    loadAllData();
    super.initState();
  }

  void onBackForm() {
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
        bottomNavigationBar: StepsNavigation(
            currentStep: currentStep,
            onStepCansel: onStepCansel,
            onStepContinue: onStepContinue,
            getSteps: getSteps,
            onBackForm: onBackForm));
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
          carYearValue: carYearValue,
          bodyType: bodyType,
          engineValue: engineValue,
          transmissionValue: transmissionValue,
          paintConditionValue: paintConditionValue,
          pullingSideValue: pullingSideValue,
          typeOfFuelValue: typeOfFuelValue,
          carPosition: carPosition,
          price: price,
          valyuta: valyuta,
          mileageValue: mileageValue,
          descriptionValue: descriptionValue,
          onCredit: onCredit,
        ),
      ),
      Step(
        isActive: currentStep >= 6,
        title: const Text(""),
        content: Maps(
          currentPosition: currentPosition,
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
      currentPosition = value;
    });
  }

  void onCredit(int newValue) {
    setState(() {
      credit = newValue;
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
          currentStep + 1;
        });
      } else {
        return;
      }
    }

    if (currentStep == 7) {
      formKey.currentState?.save();
    }

    setState(() {
      // currentStep = (currentStep += 1) % getSteps(context).length;
      if (currentStep + 1 != getSteps(context).length) {
        currentStep = currentStep += 1;
      }
    });
  }
}
