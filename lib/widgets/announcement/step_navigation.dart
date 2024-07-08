// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:avto_baraka/api/service/payments__service.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/provider/keyboard_provider.dart';
import 'package:avto_baraka/screen/imports/imports_cabinet.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/widgets/announcement/variables.dart';
import 'package:avto_baraka/widgets/toast.dart';
import 'package:toastification/toastification.dart';

class StepsNavigation extends StatelessWidget {
  StepsNavigation({
    Key? key,
    required this.getSteps,
    required this.currentStep,
    required this.onStepCansel,
    required this.onStepContinue,
    required this.onBackForm,
    this.disabledButton = false,
  }) : super(key: key);

  final List<Step> Function(BuildContext) getSteps;
  final int currentStep;
  final void Function() onStepCansel;
  final void Function() onStepContinue;
  final void Function() onBackForm;

  bool disabledButton;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: colorEmber);
    TextStyle textStyle2 = const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);
    final isLastStep = currentStep == getSteps(context).length - 1;
    return SafeArea(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
          child: Row(
            children: [
              if (currentStep != 0)
                Expanded(
                  child: ElevatedButton(
                    style: elevationButtonWhite,
                    onPressed: () {
                      onStepCansel();
                      Provider.of<KeyboardVisibilityController>(context,
                              listen: false)
                          .hideKeyboard(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: colorEmber,
                        ),
                        Text(
                          S.of(context).orqaga,
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: ElevatedButton(
                  style: elevatedButton.copyWith(
                      backgroundColor: MaterialStatePropertyAll(colorEmber)),
                  onPressed: disabledButton
                      ? null
                      : () async {
                          Provider.of<KeyboardVisibilityController>(context,
                                  listen: false)
                              .hideKeyboard(context);
                          if (currentStep == 0 && regionGroupValue < 0) {
                            toast(
                              context,
                              S.of(context).iltimosViloyatniTanlang,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 1 && districtsGroupValue < 0) {
                            toast(
                              context,
                              S.of(context).iltimosTumanniTanlang,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 2 && carTypeGroupValue < 0) {
                            toast(
                              context,
                              S.of(context).iltimosAvtomashinaTuriniTanlang,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 3 && carBrandGroupValue < 0) {
                            toast(
                              context,
                              S.of(context).iltimosAvtomashinaBrendniTanlang,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 4 && carModelGroupValue < 0) {
                            toast(
                              context,
                              S.of(context).iltimosAvtomashinaModeliniTanlang,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 6 &&
                              currentPosition.latitude == 0 &&
                              currentPosition.longitude == 0) {
                            toast(
                              context,
                              S
                                  .of(context)
                                  .iltimosLocatsiyaniKiritingAvtomatikTanlashTugmasiniBosing,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          }
                          if (currentStep == 7 && imageFileList.isEmpty) {
                            toast(
                              context,
                              S.of(context).iltimosFotosuratKiriting,
                              colorRed,
                              ToastificationType.error,
                            );
                            return;
                          } else if (isLastStep) {
                            sendDataResponseStatusText =
                                await ListingService().postAutoData(
                              {
                                "region_id": regionGroupValue,
                                "district_id": districtsGroupValue,
                                "car_type_id": carTypeGroupValue,
                                "car_brand_id": carBrandGroupValue,
                                "car_model_id": carModelGroupValue,
                                "body_type_id": bodyType.text,
                                "year": carYearValue.text,
                                "engine": engineValue.text,
                                "transmission_id": transmissionValue.text,
                                "pulling_side_id": pullingSideValue.text,
                                "mileage": mileageValue.text,
                                "description": descriptionValue.text,
                                "type_of_fuel_id": typeOfFuelValue.text,
                                "car_position": carPosition.text,
                                "lat": currentPosition.latitude,
                                "long": currentPosition.longitude,
                                "price": price.text == "" ? 0 : price.text,
                                "valyuta_id": valyuta.text,
                                "credit": credit,
                                "paint_condition": paintConditionValue.text
                              },
                              imageFileList,
                            );

                            if (sendDataResponseStatusText == "Unpaid") {
                              BlocProvider.of<ListingBloc>(context).add(
                                const ListingEventAddListing(),
                              );
                              responsDescription =
                                  await PaymentsService().paymentDesc();
                              unpaidDialog(
                                  context, responsDescription, onBackForm);
                              return;
                            }
                            if (sendDataResponseStatusText == "success") {
                              BlocProvider.of<ListingBloc>(context).add(
                                const ListingEventAddListing(),
                              );
                              successDialog(context, onBackForm);
                              return;
                            }
                            if (sendDataResponseStatusText == "Unprocessable") {
                              unprocessable(context);
                              return;
                            }

                            if (sendDataResponseStatusText == "serverError") {
                              serverError(context);
                              return;
                            }
                            return;
                          }

                          onStepContinue();
                        },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLastStep
                              ? S.of(context).saqlash
                              : S.of(context).oldinga,
                          style: textStyle2,
                        ),
                        !isLastStep
                            ? const Icon(Icons.arrow_forward_ios_outlined)
                            : const SizedBox()
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future unpaidDialog(
  BuildContext context,
  String? description,
  onBackForm,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          S.of(context).elonSaqlandi,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: colorWhite),
        ),
        content: Text(
          description ?? S.of(context).tizimdanTolFoy,
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).yangiElonJoylash),
              onPressed: () {
                Navigator.of(context).pop();
                onBackForm();
              }),
          TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge),
              child: Text(S.of(context).amalgaOshirish),
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteName.firstpayView)),
        ],
      );
    },
  );
}

Future successDialog(BuildContext context, onBackForm) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          S.of(context).elonSaqlandi,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: colorWhite),
        ),
        content: Text(
          S
              .of(context)
              .elonQabulQilindiAdministratorlarTekshirganidanSongTizimgaJoylanadi,
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodyLarge!,
              ),
              child: Text(
                S.of(context).yangiElonJoylash,
                style: TextStyle(
                  color: colorEmber,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onBackForm();
              }),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            child: Text(
              S.of(context).elonlarOynasi,
              style: TextStyle(
                color: colorEmber,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.mainScreen, (route) => false);
            },
          ),
        ],
      );
    },
  );
}

Future unprocessable(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: colorRed,
        title: Text(
          S.of(context).elonSaqlanmadi,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: colorWhite),
        ),
        content: Text(S.of(context).iltimosMalumotlarniToliqKiriting),
      );
    },
  );
}

Future serverError(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: colorRed,
        title: Text(
          "Serverda xatolik",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: colorWhite),
        ),
        content: Text(S.of(context).iltimosMalumotlarniToliqKiriting),
      );
    },
  );
}
