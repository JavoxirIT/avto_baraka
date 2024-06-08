part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentSendDataCard extends PaymentState {}

final class PaymentStateError extends PaymentState {}

class PaymentSendDataStatusState extends PaymentState {
  const PaymentSendDataStatusState({
    required this.listData,
  });

  final Map listData;

  @override
  List<Object> get props => super.props..add(listData);
}

final class PaymentStateSmsSuccuss extends PaymentState {}

final class PaymentStateVisualSendBtn extends PaymentState {}

final class PaymentStateSmsError extends PaymentState {}

final class PaymentStatePaySuccess extends PaymentState {}
final class PaymentStatePayError extends PaymentState {}

final class PaymentStatePaySendError extends PaymentState {
  const PaymentStatePaySendError({required this.exseption});

  final Exception exseption;

  @override
  List<Object> get props => super.props..add(exseption);
}
