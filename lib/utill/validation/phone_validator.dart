import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/widgets/toast.dart';
import 'package:toastification/toastification.dart';

phoneValidator(BuildContext context, String input) {
  String phoneExp = input.replaceAll(RegExp(r'\D'), '');
  // final phoneExp = RegExp(r'^\d{12}$');
  if (input == "") {
    return toast(
      context,
      S.of(context).iltimosNomeringizniKiriting,
      colorRed,
      ToastificationType.error,
    );
  } else if (phoneExp.length == 12) {
    return null;
  } else {
    return toast(
      context,
      S.of(context).telefonRaqamizniToliqKiriting,
      colorRed,
      ToastificationType.error,
    );
  }
}
