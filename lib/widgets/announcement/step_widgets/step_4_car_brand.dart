import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class CarBrandSelection extends StatefulWidget {
  const CarBrandSelection({
    super.key,
    required this.carBrandList,
    required this.initialCarBrandGroupValue,
    required this.onCarBrandChanged,
    required this.onCarModelListUpdated,
    required this.carTypeGroupValue,
  });

  final List<CarBrandsModels> carBrandList;
  final int initialCarBrandGroupValue;
  final ValueChanged<int> onCarBrandChanged;
  final ValueChanged<List<CarModels>> onCarModelListUpdated;
  final int carTypeGroupValue;

  @override
  CarBrandSelectionState createState() => CarBrandSelectionState();
}

class CarBrandSelectionState extends State<CarBrandSelection> {
  late int carBrandGroupValue;
  late List<CarModels> carModelList;

  @override
  void initState() {
    super.initState();
    carBrandGroupValue = widget.initialCarBrandGroupValue;
    carModelList = [];
  }

  TextStyle textNoDataStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: colorEmber,
  );
  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );
    if (widget.carBrandList.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Text(
            S.of(context).avvalTexnikaTuriniTanlang,
            style: textNoDataStyle,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formStepsTitle(S.of(context).brendniTanlang, context),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.carBrandList.length,
            itemBuilder: (context, index) {
              final brand = widget.carBrandList[index];
              return Card(
                shape: shape,
                elevation: 0,
                child: RadioListTile(
                  activeColor: colorWhite,
                  shape: shape,
                  tileColor:
                      carBrandGroupValue == brand.id ? unselectedItemColor : null,
                  contentPadding: contentPadding,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(children: [
                    CircleAvatar(
                      backgroundColor: backgrounColorWhite,
                      child: Image.network(
                        Config.imageUrl! + brand.logo,
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      brand.name,
                      style: TextStyle(color: colorWhite),
                    ),
                  ]),
                  value: brand.id,
                  groupValue: carBrandGroupValue,
                  onChanged: (value) async {
                    setState(() {
                      carBrandGroupValue = value!;
                    });
                    final newCarModelList = await CarService().getCarModel(
                      widget.carTypeGroupValue,
                      carBrandGroupValue,
                    );
                    setState(() {
                      carModelList = newCarModelList;
                    });
                    widget.onCarBrandChanged(carBrandGroupValue);
                    widget.onCarModelListUpdated(carModelList);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
