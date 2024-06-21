import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class CarTypeSelection extends StatefulWidget {
  const CarTypeSelection({
    super.key,
    required this.categoryList,
    required this.initialCarTypeGroupValue,
    required this.onCarTypeChanged,
    required this.onCarBrandListUpdated,
  });

  final List<CarCategoryModels> categoryList;
  final int initialCarTypeGroupValue;
  final ValueChanged<int> onCarTypeChanged;
  final ValueChanged<List<CarBrandsModels>> onCarBrandListUpdated;

  @override
  _CarTypeSelectionState createState() => _CarTypeSelectionState();
}

class _CarTypeSelectionState extends State<CarTypeSelection> {
  late int carTypeGroupValue;
  late List<CarBrandsModels> carBrandList;

  @override
  void initState() {
    super.initState();
    carTypeGroupValue = widget.initialCarTypeGroupValue;
    carBrandList = [];
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = const EdgeInsets.fromLTRB(20.0, 0, 3.0, 0);
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formStepsTitle(S.of(context).texnikaTuriniTanlang, context),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.categoryList.length,
            itemBuilder: (context, index) {
              final type = widget.categoryList[index];
              return Card(
                shape: shape,
                elevation: 0,
                child: RadioListTile(
                  activeColor: colorWhite,
                  tileColor:
                      carTypeGroupValue == type.id ? unselectedItemColor : null,
                  shape: shape,
                  contentPadding: contentPadding,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(children: [
                    CircleAvatar(
                      backgroundColor: backgrounColorWhite,
                      child: Image.network(Config.imageUrl! + type.icon,
                          height: 28.0),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      type.name,
                      style: TextStyle(color: colorWhite),
                    ),
                  ]),
                  value: type.id,
                  groupValue: carTypeGroupValue,
                  onChanged: (value) async {
                    setState(() {
                      carTypeGroupValue = value!;
                    });
                    final newCarBrandList =
                        await CarService().getBrands(carTypeGroupValue);
                    setState(() {
                      carBrandList = newCarBrandList;
                    });
                    widget.onCarTypeChanged(carTypeGroupValue);
                    widget.onCarBrandListUpdated(carBrandList);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
