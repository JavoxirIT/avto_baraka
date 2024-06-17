part of 'not_active_bloc.dart';

sealed class NotActiveState extends Equatable {
  const NotActiveState();

  @override
  List<Object> get props => [];
}

final class NotActiveInitial extends NotActiveState {}

final class NotActiveLoad extends NotActiveState {
  const NotActiveLoad({required this.list});

  final List<ListingGetModals> list;

  @override
  List<Object> get props => super.props..add(list);
}

final class NotActiveStateLoading extends NotActiveState {}

final class NotActiveStateNotData extends NotActiveState {}

final class NotActiveStateError extends NotActiveState {
  const NotActiveStateError(this.error);

  final Exception error;

  @override
  List<Object> get props => super.props..add(error);
}

final class NotActiveStateDeleteError extends NotActiveState {}
final class NotActiveStateDeleteSuccess extends NotActiveState {}
final class NotActiveStateActivitySuccess extends NotActiveState {}
final class NotActiveStateActivityError extends NotActiveState {}
