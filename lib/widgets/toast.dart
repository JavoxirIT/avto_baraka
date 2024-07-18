import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:toastification/toastification.dart';

ToastificationItem toast(
    BuildContext context, String title, Color color, ToastificationType type,
    [time]) {
  return toastification.show(
    context: context,
    title: Text(
      title,
      style: TextStyle(color: colorWhite),
    ),
    autoCloseDuration: Duration(seconds: time ?? 5),
    backgroundColor: color,
    primaryColor: colorWhite,
    type: type,
  );
}
