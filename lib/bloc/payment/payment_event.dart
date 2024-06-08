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
  const PaymentEventSend({required this.token});

  final String token;

  @override
  List<Object> get props => [token];
}
