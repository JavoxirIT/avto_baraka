import 'package:avto_baraka/screen/imports/imports_listing.dart';

String? phoneValidator(BuildContext context, String input) {
  final phoneExp = RegExp(r'[0-9]');
  if (input == "") {
    return S.of(context).maydinniToldiring;
  } else if (phoneExp.hasMatch(input)) {
    return null;
  } else {
    return S.of(context).notugriFormat;
  }
}
