import 'package:avto_baraka/screen/imports/imports_favorite.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> flutterShowToast(title) {
  return Fluttertoast.showToast(
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    msg: title,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    fontSize: 16.0,
  );
}
