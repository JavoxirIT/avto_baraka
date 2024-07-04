// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_is_empty

import 'package:avto_baraka/api/models/car_brand.models.dart';
import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/models/car_models.dart';
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/models/valyuta_model.dart';
import 'package:avto_baraka/api/service/car_service.dart';
import 'package:avto_baraka/api/service/region_service.dart';
import 'package:avto_baraka/api/service/valyuta_service.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/style/announcement_input_decoration.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/validation/validation.dart';
import 'package:avto_baraka/widgets/carousel/show_modal_bottom_sheat.dart';
import 'package:avto_baraka/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
  List<RegionModel> region = [];

  String stateName = "";
  String markName = "";
  String carName = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  final _startYear = TextEditingController(text: "0");
  final _endYear = TextEditingController(text: "0");
  final _valyuta = TextEditingController(text: "0");
  final _payStart = TextEditingController(text: "0");
  final _payEnd = TextEditingController(text: "0");

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
    final languageProvider = Provider.of<LocalProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);

    TextStyle fonmDataTextStyle = TextStyle(fontSize: 12.0, color: colorWhite);
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).kerakliElonniQidirish),
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
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: colorWhite),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: colorEmber,
                ),
                shape: shape,
                tileColor: cardBlackColor,
                onTap: () => showModalBottom(
                    context,
                    region.length * 50.0,
                    [
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: region.length,
                          itemBuilder: (context, i) {
                            final el = region[i];
                            return Card(
                              shape: shape,
                              semanticContainer: true,
                              elevation: 0,
                              color: cardBlackColor,
                              child: RadioListTile(
                                activeColor: colorWhite,
                                tileColor: regionGroupValue == el.id
                                    ? unselectedItemColor
                                    : null,
                                shape: shape,
                                contentPadding: contentPadding,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                // splashRadius: 3.0,
                                title: Text(
                                  el.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: colorWhite),
                                ),
                                value: el.id,
                                groupValue: regionGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    regionGroupValue = value!;
                                    stateName = el.name;
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
                                    ? colorEmber
                                    : cardBlackColor,
                                child: Column(
                                  children: [
                                    Image.network(
                                      Config.imageUrl! + element.icon,
                                      fit: BoxFit.cover,
                                      height: 42.0,
                                      width: 42.0,
                                    ),
                                    Text(element.name)
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              carBrandList.isNotEmpty ? sizeBox20 : const SizedBox(),
              carBrandList.isNotEmpty
                  ? ListTile(
                      title: Text(
                        markName == ""
                            ? S.of(context).markaniTanlang
                            : markName,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: colorWhite),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: colorEmber,
                      ),
                      shape: shape,
                      tileColor: cardBlackColor,
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
                                    child: RadioListTile(
                                      tileColor: carBrandValue == el.id
                                          ? unselectedItemColor
                                          : null,
                                      activeColor: colorWhite,
                                      shape: shape,
                                      contentPadding: contentPadding,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(
                                        el.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: colorWhite),
                                      ),
                                      value: el.id,
                                      groupValue: carBrandValue,
                                      onChanged: (value) async {
                                        setState(() {
                                          carBrandValue = value!;
                                          markName = el.name;
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
                  : const SizedBox(),
              carModelList.length != 0 ? sizeBox20 : const SizedBox(),
              carModelList.length != 0
                  ? ListTile(
                      title: Text(
                        carName == "" ? S.of(context).modelniTanlang : carName,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: colorWhite),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: colorEmber,
                      ),
                      shape: shape,
                      tileColor: cardBlackColor,
                      onTap: () => showModalBottom(
                          context,
                          carBrandList.length * 80.0,
                          [
                            Flexible(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: carModelList.length,
                                itemBuilder: (context, i) {
                                  final el = carModelList[i];
                                  return Card(
                                    shape: shape,
                                    semanticContainer: true,
                                    elevation: 0,
                                    // color: backgnColStepCard,
                                    child: RadioListTile(
                                      activeColor: colorWhite,
                                      tileColor: carModelValue == el.id
                                          ? unselectedItemColor
                                          : null,
                                      shape: shape,
                                      contentPadding: contentPadding,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      // splashRadius: 3.0,
                                      title: Text(
                                        el.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: colorWhite),
                                      ),
                                      value: el.id,
                                      groupValue: carModelValue,
                                      onChanged: (value) {
                                        setState(() {
                                          carModelValue = value!;
                                          carName = el.name;
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
                  : const SizedBox(),
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
                    child: input(_startYear, TextInputType.number, validate,
                        S.of(context).yilDan),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: input(_endYear, TextInputType.number, validate,
                        S.of(context).yilGacha),
                  ),
                ],
              ),
              sizeBox20,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  S.of(context).narxi,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              sizeBox20,
              Row(
                children: [
                  Expanded(
                    child: input(_payStart, TextInputType.number, validate,
                        S.of(context).dan),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: input(_payEnd, TextInputType.number, validate,
                        S.of(context).gacha),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      dropdownColor: cardBlackColor,
                      isExpanded: true,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      alignment: AlignmentDirectional.centerEnd,
                      items: valyutaList
                          .map(
                            (valyuta) => DropdownMenuItem(
                              value: valyuta.id,
                              child: Text(
                                valyuta.name,
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorEmber,
        onPressed: () => getSearch(
            token: tokenProvider.token!,
            lang: languageProvider.locale.languageCode),
        icon: Icon(
          Icons.search,
          color: colorWhite,
        ),
        label: Text(
          S.of(context).qidirish,
          style: Theme.of(context).textTheme.displaySmall,
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

  void getSearch({required String token, required String lang}) {
    BlocProvider.of<ListingBloc>(context).add(ListingEvantSearch(
      token: token,
      lang: lang,
      brand_id: carBrandValue,
      car_type: carTypeId,
      model_id: carModelValue,
      region_id: regionGroupValue,
      end_price: int.parse(_payEnd.text),
      end_year: int.parse(_endYear.text),
      start_price: int.parse(_payStart.text),
      start_year: int.parse(_startYear.text),
      valyuta: int.parse(_valyuta.text),
    ));
    Navigator.of(context).pop();
  }
}
