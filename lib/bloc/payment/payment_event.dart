part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentEventSendCard extends PaymentEvent {
  const PaymentEventSendCard({
    required this.cardNumber,
    required this.expireDate,
    required this.token,
  });

  final String cardNumber;
  final String expireDate;
  final String token;

  @override
  List<Object> get props => [cardNumber, expireDate, token];
}

class PaymentEventSmsCode extends PaymentEvent {
  const PaymentEventSmsCode({
    required this.smsCode,
    required this.token,
  });

  final String smsCode;
  final String token;

  @override
  List<Object> get props => [smsCode, token];
}

class PaymentEventSend extends PaymentEvent {
  const PaymentEventSend({
    required this.token,
    required this.ratesId,
    required this.listingId,
  });

  final String token;
  final int? ratesId;
  final int? listingId;

  @override
  List<Object> get props =>
      super.props..addAll([token, ratesId ?? 0, listingId ?? 0]);
}
