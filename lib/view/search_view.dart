// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:avto_baraka/api/models/car_brand.models.dart';
import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/models/car_models.dart';
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/models/valyuta_model.dart';
import 'package:avto_baraka/api/service/car_service.dart';
import 'package:avto_baraka/api/service/region_service.dart';
import 'package:avto_baraka/api/service/valyuta_service.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:avto_baraka/style/announcement_input_decoration.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/validation/validation.dart';
import 'package:avto_baraka/widgets/carousel/show_modal_bottom_sheat.dart';
import 'package:avto_baraka/widgets/input.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  SizedBox sizeBox20 = const SizedBox(
    height: 20.0,
  );
  int regionGroupValue = -1;
  int carTypeId = -1;
  int carBrandValue = -1;
  int carModelValue = -1;
  List<CarBrandsModels> carBrandList = [];
  List<CarCategoryModels> categoryList = [];
  List<ValyutaModels> valyutaList = [];
  List<CarModels> carModelList = [];
  List<RegionModel>? region;

  String stateName = "";
  String markName = "";
  String carName = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  final _startYear = TextEditingController();
  final _endYear = TextEditingController();
  final _valyuta = TextEditingController();
  final _payStart = TextEditingController();
  final _payEnd = TextEditingController();

  @override
  void dispose() {
    _startYear.dispose();
    _endYear.dispose();
    _valyuta.dispose();
    _payStart.dispose();
    _payEnd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle fonmDataTextStyle = const TextStyle(fontSize: 12.0);
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kerakli e`lonni qidirish"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              sizeBox20,
              ListTile(
                title: Text(
                  stateName == "" ? S.of(context).hududniTanlang : stateName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey[100],
                ),
                shape: shape,
                tileColor: Colors.black12,
                onTap: () => showModalBottom(
                    context,
                    region!.length * 50.0,
                    [
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
                                  el.nameRu,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: el.id,
                                groupValue: regionGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    regionGroupValue = value!;
                                    stateName = el.nameRu;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    true,
                    true),
              ),
              sizeBox20,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categoryList
                      .map((element) => SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  carTypeId = element.id;
                                });
                                carBrandList =
                                    await CarService().getBrands(carTypeId);

                                if (carBrandList.isEmpty) {
                                  carModelList = [];
                                }
                                setState(() {});
                              },
                              child: Card(
                                color: carTypeId == element.id
                                    ? iconSelectedColor
                                    : Colors.white,
                                child: Column(
                                  children: [
                                    Image.network(
                                      Config.imageUrl! + element.icon,
                                      fit: BoxFit.cover,
                                      height: 42.0,
                                      width: 42.0,
                                    ),
                                    Text(element.nameRu)
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              sizeBox20,
              carBrandList.isNotEmpty
                  ? ListTile(
                      title: Text(
                        markName == "" ? S.of(context).markaniTanlang : markName,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey[100],
                      ),
                      shape: shape,
                      tileColor: Colors.black12,
                      onTap: () => showModalBottom(
                          context,
                          carBrandList.length * 80.0,
                          [
                            Flexible(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: carBrandList.length,
                                itemBuilder: (context, i) {
                                  final el = carBrandList[i];
                                  return Card(
                                    shape: shape,
                                    semanticContainer: true,
                                    elevation: 0,
                                    color: backgnColStepCard,
                                    child: RadioListTile(
                                      tileColor: carBrandValue == el.id
                                          ? splashColor
                                          : null,
                                      shape: shape,
                                      contentPadding: contentPadding,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(
                                        el.nameRu,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: el.id,
                                      groupValue: carBrandValue,
                                      onChanged: (value) async {
                                        setState(() {
                                          carBrandValue = value!;
                                          markName = el.nameRu;
                                        });
                                        Navigator.of(context).pop();
                                        carModelList =
                                            await CarService().getCarModel(
                                          carTypeId,
                                          value!,
                                        );
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                          true,
                          true),
                    )
                  : sizeBox20,
              sizeBox20,
              carModelList.length != 0
                  ? ListTile(
                      title: Text(
                        carName == "" ? "Modelni  tanlang" : carName,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey[100],
                      ),
                      shape: shape,
                      tileColor: Colors.black12,
                      onTap: () => showModalBottom(
                          context,
                          carBrandList.length * 80.0,
                          [
                            Flexible(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: carModelList!.length,
                                itemBuilder: (context, i) {
                                  final el = carModelList![i];
                                  return Card(
                                    shape: shape,
                                    semanticContainer: true,
                                    elevation: 0,
                                    color: backgnColStepCard,
                                    child: RadioListTile(
                                      tileColor: carModelValue == el.id
                                          ? splashColor
                                          : null,
                                      shape: shape,
                                      contentPadding: contentPadding,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      // splashRadius: 3.0,
                                      title: Text(
                                        el.nameRu,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: el.id,
                                      groupValue: carModelValue,
                                      onChanged: (value) {
                                        setState(() {
                                          carModelValue = value!;
                                          carName = el.nameRu;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                          true,
                          true),
                    )
                  : sizeBox20,
              sizeBox20,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  S.of(context).ishlabChiqarilganYili,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              sizeBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: input(
                        _startYear, TextInputType.number, validate, S.of(context).yilDan),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: input(
                        _endYear, TextInputType.number, validate, S.of(context).yilGacha),
                  ),
                ],
              ),
              sizeBox20,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Narxi",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              sizeBox20,
              Row(
                children: [
                  Expanded(
                    child: input(
                        _payStart, TextInputType.number, validate, S.of(context).dan),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: input(
                        _payEnd, TextInputType.number, validate, S.of(context).gacha),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    region = await RegionService().getRegions();
    valyutaList = await ValyutaService().getValyuta();
    setState(() {});
  }
}
