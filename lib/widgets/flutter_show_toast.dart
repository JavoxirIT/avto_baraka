import 'package:avto_baraka/style/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> flutterShowToast(title) {
  return Fluttertoast.showToast(
    backgroundColor: iconSelectedColor,
    textColor: textColorWhite,
    msg: title,
    timeInSecForIosWeb: 2,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    fontSize: 16.0,
  );
}
