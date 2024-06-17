import 'package:avto_baraka/api/service/payments__service.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this.paymentsService) : super(PaymentInitial()) {
    on<PaymentEventSendCard>(sendCardData);
    on<PaymentEventSmsCode>(clickSmscheck);
    on<PaymentEventSend>(clickPay);
  }

  PaymentsService paymentsService;

  Future<void> sendCardData(
      PaymentEventSendCard event, Emitter<PaymentState> emit) async {
    try {
      final dataResault = await paymentsService.sendCardData(
        event.cardNumber,
        event.expireDate,
        event.token,
      );

      // emit(PaymentSendDataCard());
      if (dataResault.isEmpty) {
        emit(PaymentStateError());
      } else {
        emit(PaymentSendDataStatusState(listData: dataResault));
        await Future.delayed(const Duration(seconds: 2));
        emit(PaymentSendDataCard());
      }
    } on Exception catch (exseption) {
      debugPrint('EXSEPTION: $exseption');
    }
  }

  Future<void> clickSmscheck(
    PaymentEventSmsCode event,
    Emitter<PaymentState> emit,
  ) async {
    final data =
        await paymentsService.clickSmscheck(event.smsCode, event.token);

    if (data['status'] == "success") {
      emit(PaymentStateSmsSuccuss());
      await Future.delayed(const Duration(seconds: 2));
      emit(PaymentStateVisualSendBtn());
    } else {
      emit(PaymentStateSmsError());
    }
  }

  Future<void> clickPay(
      PaymentEventSend event, Emitter<PaymentState> emit) async {
    try {
      final data = await paymentsService.clickPay(
          event.token, event.ratesId ?? 0, event.listingId ?? 0);
      if (data['status'] != null) {
        emit(PaymentStatePaySuccess());
      } else {
        emit(PaymentStatePayError());

        // emit(PaymentInitial());
      }
    } on Exception catch (e) {
      emit(PaymentStatePaySendError(exseption: e));
    }
  }
}
