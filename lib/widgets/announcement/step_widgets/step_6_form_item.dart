import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class FormItem extends StatefulWidget {
  const FormItem({
    Key? key,
    required this.carYearValue,
    required this.bodyType,
    required this.engineValue,
    required this.transmissionValue,
    required this.paintConditionValue,
    required this.pullingSideValue,
    required this.typeOfFuelValue,
    required this.carPosition,
    required this.price,
    required this.valyuta,
    required this.mileageValue,
    required this.descriptionValue,
    required this.onCredit,
  }) : super(key: key);

  final TextEditingController carYearValue;
  final TextEditingController bodyType;
  final TextEditingController engineValue;
  final TextEditingController transmissionValue;
  final TextEditingController paintConditionValue;
  final TextEditingController pullingSideValue;
  final TextEditingController typeOfFuelValue;
  final TextEditingController carPosition;
  final TextEditingController price;
  final TextEditingController valyuta;
  final TextEditingController mileageValue;
  final TextEditingController descriptionValue;
  final ValueChanged<int> onCredit;

  @override
  FormItemState createState() => FormItemState();
}

class FormItemState extends State<FormItem> {
  bool creditCheckBoxValue = false;
  List<CarBodyModels> carBodyList = [];
  List<CarTransmissionModels> carTransmissionList = [];
  List<CarPaintConditionModel> carPaintConditionList = [];
  List<CarPullingSideModels> carPullingSideList = [];
  List<CarFuelsModels> carFuelsList = [];
  List<ValyutaModels> valyutaList = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  TextStyle fonmDataTextStyle = TextStyle(fontSize: 12.0, color: colorWhite);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: Column(
        children: [
          // formStepsTitle("Batafsil malumotlari", context),
          GridView(
            controller: scrollController,
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
                cursorColor: colorEmber,
                style: TextStyle(color: colorWhite),
                maxLength: 4,
                controller: widget.carYearValue,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    validate(value, S.of(context).abtomashinaYiliniKiriting),
                decoration: InputDecoration(
                  focusedBorder: formInputBorder,
                  enabledBorder: formInputBorder,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(
                    S.of(context).ishlabChiqarilganYili,
                  ),
                ),
              ),
              // кузов
              DropdownButtonFormField(
                value: int.tryParse(widget.bodyType.text),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                alignment: AlignmentDirectional.centerEnd,
                // validator: (value) =>
                //     validate(value, S.of(context).kuzovTurinitanlang),
                items: carBodyList
                    .map((e) => DropdownMenuItem(
                        enabled: true,
                        value: e.id,
                        child: Text(
                          e.name,
                          style: fonmDataTextStyle,
                        )))
                    .toList(),
                onChanged: (value) {
                  widget.bodyType.text = value.toString();
                },
                decoration:
                    announcementInputDecoration(S.of(context).kuzovTuri),
              ),
              // объём двигателя
              TextFormField(
                cursorColor: colorEmber,
                style: TextStyle(color: colorWhite),
                decoration:
                    announcementInputDecoration(S.of(context).dvigatelHajmi),
                keyboardType: TextInputType.number,
                controller: widget.engineValue,
                // validator: (value) =>
                //     validate(value, S.of(context).dvigatelHajminiKiriting),
              ),
              // carTransmissionList
              DropdownButtonFormField(
                value: int.tryParse(widget.transmissionValue.text),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                alignment: AlignmentDirectional.centerEnd,
                items: carTransmissionList
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                            style: fonmDataTextStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  widget.transmissionValue.text = value.toString();
                },
                decoration: announcementInputDecoration(
                  S.of(context).uzatishQutisi,
                ),
                // validator: (value) =>
                //     validate(value, S.of(context).uzatishQutisiniTanlang),
              ),
              // paintCondition
              DropdownButtonFormField(
                value: int.tryParse(widget.paintConditionValue.text),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                alignment: AlignmentDirectional.centerEnd,
                items: carPaintConditionList
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                            style: fonmDataTextStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  widget.paintConditionValue.text = value.toString();
                },
                decoration: announcementInputDecoration(
                  S.of(context).boyoqHolati,
                ),
                // validator: (value) =>
                //     validate(value, S.of(context).boyoqHolatiniKiriting),
              ),
              // pullingSide
              DropdownButtonFormField(
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                alignment: AlignmentDirectional.centerEnd,
                value: int.tryParse(widget.pullingSideValue.text),
                items: carPullingSideList
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                            style: fonmDataTextStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  widget.pullingSideValue.text = value.toString();
                },
                decoration: announcementInputDecoration(
                  S.of(context).tortuvchiTomon,
                ),
                // validator: (value) =>
                //     validate(value, S.of(context).tortishTomoniniTanlang),
              ),
              // carFuelsList
              DropdownButtonFormField(
                value: int.tryParse(widget.typeOfFuelValue.text),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                alignment: AlignmentDirectional.centerEnd,
                items: carFuelsList
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.name,
                            style: fonmDataTextStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  widget.typeOfFuelValue.text = value.toString();
                },
                decoration: announcementInputDecoration(
                  S.of(context).yoqilgiTuri,
                ),
                validator: (value) =>
                    validate(value, S.of(context).yoqilgiTuriniTanlang),
              ),
              // _carPosition
              TextFormField(
                cursorColor: colorEmber,
                style: TextStyle(color: colorWhite),
                controller: widget.carPosition,
                keyboardType: TextInputType.streetAddress,
                decoration: announcementInputDecoration(
                  S.of(context).versiyasiniTanlang,
                ),
                // validator: (value) => validate(
                //   value,
                //   S.of(context).versiyasiniTanlang,
                // ),
              ),
              //  NARXI
              TextFormField(
                cursorColor: colorEmber,
                style: TextStyle(color: colorWhite),
                controller: widget.price,
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
                          valyuta.name,
                          style: fonmDataTextStyle,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  widget.valyuta.text = value.toString();
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
            cursorColor: colorEmber,
            style: TextStyle(color: colorWhite),
            controller: widget.mileageValue,
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
            cursorColor: colorEmber,
            style: TextStyle(color: colorWhite),
            controller: widget.descriptionValue,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            decoration:
                announcementInputDecoration(S.of(context).qoshimchaMalumot),
            // validator: (value) =>
            //     validate(value, S.of(context).qoshimchaMalumotniKriting),
            maxLength: 100,
          ),
          //
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80.0,
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    checkColor: colorEmber,
                    fillColor: WidgetStatePropertyAll(colorWhite),
                    value: creditCheckBoxValue,
                    onChanged: (value) {
                      setState(() {
                        creditCheckBoxValue = value!;
                        if (value) {
                          widget.onCredit(1);
                        } else {
                          widget.onCredit(0);
                        }
                      });
                    },
                  ),
                ),
                Text(S.of(context).kriditgaBeriladimi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    carBodyList = await CarService().getCarBody();
    carTransmissionList = await CarService().getCarTransmision();
    carPaintConditionList = await CarService().getCarPointCondition();
    carPullingSideList = await CarService().getCarPullingSide();
    carFuelsList = await CarService().getCarTypeFuels();
    valyutaList = await ValyutaService().getValyuta();
  }
}
