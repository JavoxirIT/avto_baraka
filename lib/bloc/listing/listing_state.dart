part of 'listing_bloc.dart';

sealed class ListingState extends Equatable {
  const ListingState();
  @override
  List<Object> get props => [];
}

final class ListingStateInitial extends ListingState {}

final class ListingStateLoading extends ListingState {}

//
final class ListingStateLoad extends ListingState {
  const ListingStateLoad({
    required this.listing,
    required this.currentPage,
    required this.hasReachedMax,
  });
  final List<ListingGetModals> listing;
  final int currentPage;
  final bool hasReachedMax;

  @override
  List<Object> get props =>
      super.props..add([listing, currentPage, hasReachedMax]);
}

final class ListingStateNoData extends ListingState {}

// ошибка при получение данных
final class ListingStateError extends ListingState {
  const ListingStateError({
    required this.exception,
  });
  final Exception exception;

  @override
  List<Object> get props => super.props..add(exception);
}

final class ListingStateNoDataSearch extends ListingState {}

final class ListingStateHasDataSearch extends ListingState {
  const ListingStateHasDataSearch({required this.count});

  final int count;
  @override
  List<Object> get props => super.props..add([count]);
}

// on refresh
final class ListingStateRefresh extends ListingState {
  const ListingStateRefresh(
    this.complater,
  );
  final Completer? complater;
}
