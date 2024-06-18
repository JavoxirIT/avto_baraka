import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:provider/provider.dart';
import 'package:avto_baraka/api/service/authorization_service.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/utill/phone_mask/phone_mask.dart';
import 'package:avto_baraka/utill/validation/phone_validator.dart';
import 'package:avto_baraka/widgets/flutter_show_toast.dart';
import 'package:avto_baraka/generated/l10n.dart';

class MainCarouselFormRegistration extends StatefulWidget {
  const MainCarouselFormRegistration({Key? key}) : super(key: key);

  @override
  MainCarouselFormRegistrationState createState() =>
      MainCarouselFormRegistrationState();
}

class MainCarouselFormRegistrationState
    extends State<MainCarouselFormRegistration> with CodeAutoFill {
  late String responseData;
  Map? accessTokenData;
  late String _appSignature;
  String? _code;

  final _formKey = GlobalKey<FormState>();
  final phoneNumber = TextEditingController();
  final smsCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAppSignature();
    requestSmsPermission();
    _listenForSmsCode();
  }

  void _listenForSmsCode() async {
    await SmsAutoFill().listenForCode();
    // debugPrint('РАБОТАЕТ');
  }

  Future<void> requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }

  Future<void> getAppSignature() async {
    _appSignature = await SmsAutoFill().getAppSignature;
    // debugPrint('App Signature: $_appSignature');
  }

  @override
  void codeUpdated() {
    // debugPrint('codeUpdated called');
    setState(() {
      _code = code;
      smsCode.text = _code!;
      // debugPrint('code: $_code');
    });
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<TokenProvider>(
        builder: (context, tokenProvider, _) {
          return Container(
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
                            decoration: InputDecoration(
                              hintText: "+998 (XX) XXX-XX-XX",
                              hintStyle: TextStyle(color: colorWhite),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(0.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) =>
                                phoneValidator(context, value!),
                          ),
                        ),
                      ),
                      sizedBoxH20,
                      SizedBox(
                        height: 58.0,
                        child: ElevatedButton(
                          style: elevatedButtonMap.copyWith(
                              backgroundColor:
                                  MaterialStatePropertyAll(iconSelectedColor)),
                          onPressed: () async {
                            if (phoneNumber.text.isEmpty) {
                              flutterShowToast(
                                  S.of(context).iltimosNomeringizniKiriting);
                              return;
                            }

                            flutterShowToast(
                              S.of(context).iltimosSmsXabarniKutibTuring,
                            );
                            responseData = await Authorization()
                                .postNumber(phoneNumber.text, _appSignature);
                          },
                          child: Text(
                            S.of(context).yuborish,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxH20,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    S.of(context).smsKodniKiriting.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                sizedBoxH20,
                PinFieldAutoFill(
                  controller: TextEditingController(text: _code),
                  codeLength: 6,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder:
                        const FixedColorBuilder(Color(0xFF008080)),
                    gapSpace: 10.0,
                    radius: const Radius.circular(5.0),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                    bgColorBuilder: const FixedColorBuilder(
                      Colors.white,
                    ),
                  ),
                  onCodeChanged: (code) async {
                    if (code!.length == 6) {
                      setState(() {
                        _code = code;
                      });

                      accessTokenData = await Authorization()
                          .sendphoneAndCode(phoneNumber.text, code);
                      final accessToken = accessTokenData!["access_token"];
                      final userId = accessTokenData!["user_id"];

                      tokenProvider.accessToken = accessToken;
                      tokenProvider.accessUserID = userId.toString();
                      tokenProvider.tokenSetLocale(
                        accessToken,
                      );
                      tokenProvider.userIdSetLocale(userId.toString());

                      // debugPrint('accessTokenData: $accessTokenData');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
