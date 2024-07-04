import 'package:avto_baraka/screen/imports/imports_announcement.dart';

List<DistrictsModel> districts = [];
List<CarCategoryModels> categoryList = [];
List<CarBrandsModels> carBrandList = [];
List<CarModels> carModelList = [];
List<XFile> imageFileList = [];
// step radio group
int regionGroupValue = -1;
int districtsGroupValue = -1;
int carTypeGroupValue = -1;
int carBrandGroupValue = -1;
int carModelGroupValue = -1;
//
String sendDataResponseStatusText = "";
//
String? responsDescription;
// form item value
int credit = 0;
final carYearValue = TextEditingController(text: "2022");
final bodyType = TextEditingController(text: "1");
final engineValue = TextEditingController(text: "1.6");
final transmissionValue = TextEditingController(text: "1");
final paintConditionValue = TextEditingController(text: "1");
final pullingSideValue = TextEditingController(text: "1");
final mileageValue = TextEditingController();
final descriptionValue = TextEditingController(text: "");
final typeOfFuelValue = TextEditingController(text: "1");
final carPosition = TextEditingController();
final price = TextEditingController();
final valyuta = TextEditingController();

//
LatLng currentPosition = const LatLng(0, 0);
