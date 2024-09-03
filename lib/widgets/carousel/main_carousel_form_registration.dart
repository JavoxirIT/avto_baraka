// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:avto_baraka/style/outline_input_border.dart';
import 'package:avto_baraka/widgets/toast.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:provider/provider.dart';
import 'package:avto_baraka/api/service/authorization_service.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/utill/phone_mask/phone_mask.dart';
import 'package:avto_baraka/utill/validation/phone_validator.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:toastification/toastification.dart';
// import 'package:flutter/services.dart';

class MainCarouselFormRegistration extends StatefulWidget {
  const MainCarouselFormRegistration({Key? key}) : super(key: key);

  @override
  MainCarouselFormRegistrationState createState() =>
      MainCarouselFormRegistrationState();
}

class MainCarouselFormRegistrationState
    extends State<MainCarouselFormRegistration> {
  String? responseData;
  Map? accessTokenData;
  late String _appSignature;
  // String? _code;

  // bool isDisabled = true;
  // int _start = 60; // Таймер на 60 секунд
  // Timer? _timer;

  final _formKey = GlobalKey<FormState>();
  final phoneNumber = TextEditingController();
  final TextEditingController _code = TextEditingController();
  bool hasSimCard = false;
  @override
  void initState() {
    super.initState();
    // requestSmsPermission();
    // _listenForSmsCode();
    getAppSignature();
    // checkSimCardAndInitialize();
    // var data = SmsAutoFill().hint;
    // data.then((value) {
    //   if (value != null) {
    //     phoneNumber.text = value;
    //   }
    // });
  }

  // Future<void> checkSimCardAndInitialize() async {
  //   hasSimCard = await hasSimCardCheck();
  //   if (hasSimCard) {
  //     requestSmsPermission();
  //     _listenForSmsCode();
  //     var data = SmsAutoFill().hint;
  //     data.then((value) {
  //       if (value != null) {
  //         phoneNumber.text = value;
  //       }
  //     });
  //   } else {
  //     toast(
  //       context,
  //       S.of(context).deviceSimNotSuported,
  //       colorEmber,
  //       ToastificationType.error,
  //     );
  //     debugPrint('на устройстве нет sim');
  //   }
  // }

  // Future<bool> hasSimCardCheck() async {
  //   const platform = MethodChannel('com.autobaraka.auto_baraka/simcheck');
  //   try {
  //     final bool result = await platform.invokeMethod('hasSimCard');
  //     return result;
  //   } on PlatformException catch (e) {
  //     debugPrint("Не удалось получить статус SIM-карты: '${e.message}'.");
  //     return false;
  //   }
  // }

  // void _listenForSmsCode() async {
  //   await SmsAutoFill().listenForCode();
  //   // debugPrint('РАБОТАЕТ');
  // }

  // Future<void> requestSmsPermission() async {
  //   var status = await Permission.sms.status;
  //   debugPrint('$status');

  //   if (!status.isGranted) {
  //     await Permission.sms.request();
  //   }
  // }

  Future<void> getAppSignature() async {
    _appSignature = await SmsAutoFill().getAppSignature;
    debugPrint('App Signature: $_appSignature');
  }

  // void _startTimer() {
  //   _start = 60;
  //   if (_timer != null) {
  //     _timer!.cancel();
  //   }
  //   _timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (timer) {
  //       setState(
  //         () {
  //           if (_start == 0 || _code.text != "") {
  //             timer.cancel();
  //             isDisabled = true;
  //           } else {
  //             _start--;
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  // void codeUpdated() {
  // debugPrint('codeUpdated called');
  // setState(() {
  // _code.text = code!;
  // smsCode.text = _code!;
  // debugPrint('code: $_code');
  // });
  // }

  @override
  void dispose() {
    phoneNumber.dispose();
    _code.dispose();
    // SmsAutoFill().unregisterListener();
    // if (_timer != null) {
    //   _timer!.cancel();
    // }
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
                    border: Border.all(width: 1.0, color: colorEmber),
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
                                  Radius.circular(0.0),
                                ),
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
                            backgroundColor: WidgetStatePropertyAll(colorEmber),
                          ),
                          onPressed: () async {
                            final validate =
                                phoneValidator(context, phoneNumber.text);

                            if (validate == null) {
                              // _startTimer();
                              toast(
                                context,
                                S.of(context).iltimosSmsXabarniKutibTuring,
                                colorEmber,
                                ToastificationType.info,
                              );

                              responseData = await Authorization()
                                  .postNumber(phoneNumber.text, _appSignature);

                              if (responseData == "error") {
                                // toast(
                                //   context,
                                //   "SMS xabar yuborishda xatolik",
                                //   colorEmber,
                                //   ToastificationType.warning,
                                // );
                                debugPrint("SMS xabar yuborishda xatolik");
                              }
                            } else {
                              return;
                            }
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
                TextFieldPinAutoFill(
                  // cursor: Cursor(
                  //   width: 1,
                  //   height: 30,
                  //   color: colorEmber,
                  //   radius: const Radius.circular(1),
                  //   enabled: true,
                  // ),
                  // controller: _code,

                  decoration: InputDecoration(
                    focusedBorder: formInputBorder.copyWith(
                        borderSide: BorderSide(color: colorEmber)),
                    enabledBorder: formInputBorder,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),

                  currentCode: _code.text,
                  codeLength: 6,
                  // decoration: BoxLooseDecoration(
                  //   strokeColorBuilder: FixedColorBuilder(colorEmber),
                  //   gapSpace: 10.0,
                  //   radius: const Radius.circular(5.0),
                  //   textStyle: TextStyle(
                  //     fontSize: 20,
                  //     color: colorWhite,
                  //     fontFamily: "Roboto",
                  //   ),
                  // ),
                  onCodeSubmitted: (p0) {},
                  onCodeChanged: (code) async {
                    final currentContext = context;
                    if (code.length == 6) {
                      setState(() {
                        _code.text = code;
                      });
                      toast(
                        context,
                        S
                            .of(context)
                            .smsKodTasdiqlashgaYuborildiNIltimosKutibTuring(
                                '\n'),
                        colorEmber,
                        ToastificationType.info,
                      );
                      // request
                      accessTokenData = await Authorization()
                          .sendphoneAndCode(phoneNumber.text, code);
                      if (accessTokenData!["access_token"] != null &&
                          accessTokenData!["user_id"] != null) {
                        toast(
                          currentContext,
                          S
                              .of(context)
                              .smskodTasdiqlandindaturgaKirishUchunTugmaniBosing(
                                  '\n'),
                          colorEmber,
                          ToastificationType.info,
                        );
                        final accessToken = accessTokenData!["access_token"];
                        final userId = accessTokenData!["user_id"];

                        tokenProvider.accessToken = accessToken;
                        tokenProvider.accessUserID = userId.toString();
                        tokenProvider.tokenSetLocale(
                          accessToken,
                        );
                        tokenProvider.userIdSetLocale(userId.toString());
                      } else {
                        toast(
                          currentContext,
                          "SMS kod tasdiqlanmadi",
                          colorRed,
                          ToastificationType.warning,
                        );
                      }
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
