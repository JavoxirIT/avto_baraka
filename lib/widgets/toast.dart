import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:toastification/toastification.dart';

ToastificationItem toast(
    BuildContext context, String title, Color color, ToastificationType type) {
  return toastification.show(
    context: context,
    title: Text(
      title,
      style: TextStyle(color: colorWhite),
    ),
    autoCloseDuration: const Duration(seconds: 5),
    backgroundColor: color,
    primaryColor: colorWhite,
    type: type,
  );
}
