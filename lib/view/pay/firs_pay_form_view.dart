import 'package:avto_baraka/bloc/payment/payment_bloc.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/sized_box_10.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/utill/mack/bank_card_mack.dart';
import 'package:avto_baraka/utill/mack/bank_card_term.dart';
import 'package:avto_baraka/utill/validation/plastic_validate.dart';
import 'package:avto_baraka/utill/validation/validity_period.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class FirstPayFormView extends StatefulWidget {
  const FirstPayFormView({Key? key}) : super(key: key);

  @override
  FirstPayFormViewPayState createState() => FirstPayFormViewPayState();
}

class FirstPayFormViewPayState extends State<FirstPayFormView> {
  final formKey = GlobalKey<FormState>();
  final _bankCard = TextEditingController();
  final _cardTerm = TextEditingController();
  final _smsCode = TextEditingController();

  int ratesId = -1;
  int listingId = -1;

  @override
  void dispose() {
    _bankCard.dispose();
    _cardTerm.dispose();
    _smsCode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null) {
      Map<String, dynamic> arguments =
          setting.arguments as Map<String, dynamic>;
      ratesId = arguments['ratesId'];
      listingId = arguments['listingId'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    TextStyle textStyle =
        const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800);
    TextStyle inputTextStyle =
        TextStyle(fontSize: 18.0, color: unselectedItemColor);
    OutlineInputBorder focusBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: unselectedItemColor, width: 1),
    );

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: unselectedItemColor, width: 3.0),
    );
    OutlineInputBorder errordBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: colorRed, width: 3.0),
    );
    EdgeInsets padding = const EdgeInsets.all(0);
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.always;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentSendDataStatusState) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          state.listData['status'] == "success"
                              ? S.of(context).diqqat
                              : S.of(context).xatolik,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        content: state.listData['status'] == "success"
                            ? Text(
                                S
                                    .of(context)
                                    .tasdiqlashUchunManashuNumGaSmsKodYuborildi(
                                        state.listData['phone']),
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(state.listData['message']),
                      );
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                  });
                }
              },
            );
          }
          if (state is PaymentStateSmsSuccuss) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          S.of(context).smsKodTasdiqlandi,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        content: Text(
                          S.of(context).amalgaOshirishTugmasiniBosing,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).pop();
                  });
                }
              },
            );
          }
          if (state is PaymentStatePaySuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          S.of(context).tolovMuvofaqayatliOtkazildi,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      );
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).pushNamed(RouteName.cobinetScreen);
                    Navigator.of(context).pop();
                  });
                }
              },
            );
          }
          if (state is PaymentStatePayError) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(
                          S.of(context).tolovAmalgaOshirilmadi,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: colorRed,
                                  ),
                        ),
                        content: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteName.firstpayView);
                          },
                          style: elevatedButton.copyWith(
                            minimumSize: const MaterialStatePropertyAll(
                              Size(88, 47),
                            ),
                          ),
                          child: Text(S.of(context).qaytaUrinibKorish),
                        ),
                      );
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                }
              },
            );
          }

          return ListView(
            children: [
              sendNumberCard(
                  context,
                  textStyle,
                  inputTextStyle,
                  focusBorder,
                  enabledBorder,
                  errordBorder,
                  padding,
                  floatingLabelBehavior,
                  state,
                  tokenProvider),
              if (state is PaymentSendDataCard ||
                  state is PaymentStateSmsSuccuss ||
                  state is PaymentStateVisualSendBtn)
                sendSmsCode(context, state, tokenProvider),
              sizedBoxH20,
              if (state is PaymentStateVisualSendBtn)
                Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PaymentBloc>(context).add(
                        PaymentEventSend(
                          token: tokenProvider.token!,
                          ratesId: ratesId,
                          listingId: listingId,
                        ),
                      );
                    },
                    style: elevatedButton.copyWith(
                        minimumSize: const MaterialStatePropertyAll(
                          Size(88, 47),
                        ),
                        backgroundColor: MaterialStatePropertyAll(colorEmber)),
                    child: Text(S.of(context).amalgaOshirish),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  Container sendSmsCode(
      BuildContext context, PaymentState state, TokenProvider tokenProvider) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizedBoxH20,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              S.of(context).smsKodniKiriting,
            ),
          ),
          sizedBox10,
          PinFieldAutoFill(
            controller: _smsCode,
            codeLength: 6,
            decoration: BoxLooseDecoration(
              strokeColorBuilder: FixedColorBuilder(unselectedItemColor),
              gapSpace: 10.0,
              radius: const Radius.circular(5.0),
              textStyle: TextStyle(
                fontSize: 20,
                color: unselectedItemColor,
                fontFamily: "Roboto",
              ),
              bgColorBuilder: const FixedColorBuilder(
                Colors.white,
              ),
            ),
            // onCodeChanged: (code) async {
            //   if (code!.length == 6) {}
            // },
          ),
          sizedBoxH20,
          ElevatedButton(
            onPressed: state is PaymentStateSmsSuccuss ||
                    state is PaymentStateVisualSendBtn
                ? null
                : () {
                    if (_smsCode.text.length == 6) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        PaymentEventSmsCode(
                          smsCode: _smsCode.text,
                          token: tokenProvider.token!,
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              S.of(context).smsKodniToliqKiriting,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        },
                      );
                      Future.delayed(
                          const Duration(
                            seconds: 2,
                          ), () {
                        Navigator.of(context).pop();
                      });
                    }
                  },
            style: elevatedButton.copyWith(
                minimumSize: MaterialStatePropertyAll(
                  Size(MediaQuery.of(context).size.width, 47),
                ),
                backgroundColor: MaterialStatePropertyAll(colorEmber)),
            child: Text(
              S.of(context).kodniYuborsh,
            ),
          )
        ],
      ),
    );
  }

  Form sendNumberCard(
      BuildContext context,
      TextStyle textStyle,
      TextStyle inputTextStyle,
      OutlineInputBorder focusBorder,
      OutlineInputBorder enabledBorder,
      OutlineInputBorder errordBorder,
      EdgeInsets padding,
      FloatingLabelBehavior floatingLabelBehavior,
      PaymentState state,
      TokenProvider tokenProvider) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 35.0, right: 35.0, bottom: 50.0),
              child: Center(
                child: Text(
                  S.of(context).kartaMalumotlariniKiriting,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF008080),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            TextFormField(
              inputFormatters: [bankCardMask],
              controller: _bankCard,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: Text(S.of(context).pkRaqami, style: textStyle),
                hintText: "**** **** **** ****",
                hintStyle: inputTextStyle,
                focusedBorder: focusBorder,
                enabledBorder: enabledBorder,
                errorBorder: errordBorder,
                focusedErrorBorder: errordBorder,
                contentPadding: padding,
                floatingLabelBehavior: floatingLabelBehavior,
              ),
              style: inputTextStyle,
              textAlign: TextAlign.center,
              validator: (value) => plastikValidate(context, value!),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    inputFormatters: [bankCardTerm],
                    controller: _cardTerm,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text(
                        S.of(context).pkAmalQilishMuddati,
                        style: textStyle,
                      ),
                      hintText: "**/**",
                      hintStyle: inputTextStyle,
                      focusedBorder: focusBorder,
                      enabledBorder: enabledBorder,
                      errorBorder: errordBorder,
                      focusedErrorBorder: errordBorder,
                      contentPadding: padding,
                      floatingLabelBehavior: floatingLabelBehavior,
                    ),
                    style: inputTextStyle,
                    textAlign: TextAlign.center,
                    validator: (value) => validityPeriod(context, value!),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: state is PaymentSendDataCard ||
                            state is PaymentStateSmsSuccuss ||
                            state is PaymentStateVisualSendBtn
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<PaymentBloc>(context).add(
                                PaymentEventSendCard(
                                  cardNumber:
                                      _bankCard.text.replaceAll(" ", ""),
                                  expireDate:
                                      _cardTerm.text.replaceAll("/", ""),
                                  token: tokenProvider.token!,
                                ),
                              );
                            }
                          },
                    style: elevatedButton.copyWith(
                        minimumSize: const MaterialStatePropertyAll(
                          Size(0, 47),
                        ),
                        backgroundColor: MaterialStatePropertyAll(colorEmber)),
                    child: Text(
                      S.of(context).yuborish,
                    ),
                  ),
                ),
              ],
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
