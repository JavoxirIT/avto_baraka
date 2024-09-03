import 'package:avto_baraka/api/models/credit_models.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/view/credit/credit_table.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  CreditScreenState createState() => CreditScreenState();
}

class CreditScreenState extends State<CreditScreen> {
  bool loading = false;
  List<CreditData> list = [];
  int groupValue = -1;

  late int listingId;
  late int price;
  late String currency;

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    Map<String, dynamic> arguments = setting.arguments as Map<String, dynamic>;
    listingId = arguments["listingId"];
    price = arguments["price"];
    currency = arguments["currency"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).kreditKalkulatori.toUpperCase()),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(children: [
          Card(
            child: ListTile(
              leading: Text(
                S.of(context).rasmiyIshlamaydi,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Radio(
                fillColor: WidgetStatePropertyAll(colorWhite),
                value: 2,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value!;
                    loading = true;
                  });
                  postDataCredit(
                      currency: currency, bsumma: price, type: groupValue);
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Text(
                S.of(context).rasmiyIshiBor,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Radio(
                fillColor: WidgetStatePropertyAll(colorWhite),
                value: 3,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value!;
                    loading = true;
                  });
                  postDataCredit(
                      currency: currency, bsumma: price, type: groupValue);
                },
              ),
            ),
          ),
          sizedBoxH20,
          loading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final data = list[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: cardBlackColor,
                        ),
                        child: CreditTable(data: data),
                      );
                    },
                  ),
                )
        ]),
      ),
    );
  }

  Future<void> postDataCredit({
    required String? currency,
    required int? bsumma,
    required int type,
  }) async {
    list.clear();
    list = await ValyutaService().getCreditData(currency!, type, bsumma!);

    setState(() {
      loading = false;
    });
  }
}
