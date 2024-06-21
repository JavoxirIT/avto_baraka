import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class StepCarModels extends StatefulWidget {
  const StepCarModels({
    Key? key,
    required this.initialCarModelGroupValue,
    required this.carModelList,
    required this.oncarModelGroupValue,
  }) : super(key: key);

  final int initialCarModelGroupValue;
  final List<CarModels> carModelList;
  final ValueChanged<int> oncarModelGroupValue;

  @override
  StepCarModelsState createState() => StepCarModelsState();
}

class StepCarModelsState extends State<StepCarModels> {
  late int carModelGroupValue;

  @override
  void initState() {
    carModelGroupValue = widget.initialCarModelGroupValue;
    super.initState();
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
        formStepsTitle(S.of(context).markaniTanlang, context),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return widget.carModelList.isEmpty
                ? SizedBox(
                    child: Text(S.of(context).avvalAvtotransportTuriniTanlang),
                  )
                : Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: widget.carModelList.length,
                      itemBuilder: (context, index) {
                        final names = widget.carModelList[index];
                        return Card(
                          shape: shape,
                          elevation: 0,
                          child: RadioListTile(
                            activeColor: colorWhite,
                            shape: shape,
                            tileColor: carModelGroupValue == names.id
                                ? unselectedItemColor
                                : null,
                            contentPadding: contentPadding,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Row(
                              children: [
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
                                  names.name,
                                  style: TextStyle(color: colorWhite),
                                ),
                              ],
                            ),
                            value: names.id,
                            groupValue: carModelGroupValue,
                            onChanged: (value) {
                              setState(() {
                                carModelGroupValue = value!;
                              });
                              widget.oncarModelGroupValue(carModelGroupValue);
                            },
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}
