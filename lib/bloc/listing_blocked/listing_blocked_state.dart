part of 'listing_blocked_bloc.dart';

sealed class ListingBlockedState extends Equatable {
  const ListingBlockedState();

  @override
  List<Object> get props => [];
}

final class ListingBlockedInitial extends ListingBlockedState {}

final class ListingBlockedStateLoad extends ListingBlockedState {
  const ListingBlockedStateLoad({
    required this.blockedList,
  });
  final List<ListingGetModals> blockedList;

  @override
  List<Object> get props => super.props..add(blockedList);
}

final class ListingBlockedStateNotData extends ListingBlockedState {}

final class ListingBlockedStateError extends ListingBlockedState {
  const ListingBlockedStateError({
    required this.exception,
  });
  final Exception exception;

  @override
  List<Object> get props => super.props..add(exception);
}
