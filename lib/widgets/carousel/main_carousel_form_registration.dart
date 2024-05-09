import 'package:avto_baraka/api/models/send_phone_models.dart';
import 'package:avto_baraka/api/regions_repository/send_phone_service.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:avto_baraka/utill/phone_mask/phone_mask.dart';
import 'package:avto_baraka/utill/validation/phone_validator.dart';
import 'package:avto_baraka/widgets/flutterShowToast.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MainCarouselFormRegistration extends StatefulWidget {
  const MainCarouselFormRegistration({Key? key}) : super(key: key);

  @override
  MainCarouselFormRegistrationState createState() =>
      MainCarouselFormRegistrationState();
}

class MainCarouselFormRegistrationState
    extends State<MainCarouselFormRegistration> {
  late SendPhoneModels responseData;

  final _formKey = GlobalKey<FormState>();
  final phoneNumber = TextEditingController();
  final smsCode = TextEditingController();

  @override
  void dispose() {
    phoneNumber.dispose();
    smsCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    final fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      // key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).telefon.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              foregroundDecoration: BoxDecoration(
                border: Border.all(width: 1.0, color: elevatedButtonColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        inputFormatters: [phoneMask],
                        controller: phoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "+998 (99) 999-99-99",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) => phoneValidator(value!),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    height: 58.0,
                    child: ElevatedButton(
                      style: elevatedButtonMap,
                      onPressed: () async {
                        if (phoneNumber.text.isEmpty) {
                          flutterShowToast(
                              S.of(context).iltimosNomeringizniKiriting);
                          return;
                        }
                        responseData = await SendPhoneService()
                            .postNumber(phoneNumber.text);
                        flutterShowToast(responseData.message);
                        smsCode.text = responseData.code.toString();
                      },
                      child: Text(
                        S.of(context).yuborish,
                        // style: TextStyle(fontSize: 16.0, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).smsKodniKiriting.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 20.0),
            Pinput(
              length: 6,
              controller: smsCode,
              defaultPinTheme: defaultPinTheme,
              // validator: (value) {
              //   return value == '2222' ? null : S.of(context).notugriKod;
              // },
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
