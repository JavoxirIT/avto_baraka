import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class Region extends StatefulWidget {
  const Region({
    Key? key,
    required this.initiaRegionGroupValue,
    required this.onRegionGroupValue,
  }) : super(key: key);

  final int initiaRegionGroupValue;
  final ValueChanged<int> onRegionGroupValue;

  @override
  RegionState createState() => RegionState();
}

class RegionState extends State<Region> {
  late int regionGroupValue;
  List<RegionModel>? region;

  @override
  void initState() {
    loadRegion();
    regionGroupValue = widget.initiaRegionGroupValue;
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
                          color: cardBlackColor,
                          child: RadioListTile(
                            tileColor: regionGroupValue == el.id
                                ? unselectedItemColor
                                : null,
                            shape: shape,
                            contentPadding: contentPadding,
                            controlAffinity: ListTileControlAffinity.trailing,
                            // splashRadius: 3.0,
                            activeColor: colorWhite,
                            title: Text(
                              el.name,
                              style: TextStyle(color: colorWhite),
                            ),
                            value: el.id,
                            groupValue: regionGroupValue,
                            onChanged: (value) {
                              setState(() {
                                regionGroupValue = value!;
                                widget.onRegionGroupValue(value);
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
    );
  }

  Future<void> loadRegion() async {
    region = await RegionService().getRegions();
    if (mounted) {
      setState(() {});
    }
  }
}
