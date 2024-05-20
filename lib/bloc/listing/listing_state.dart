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
  });
  final List<ListingGetModals> listing;

  @override
  List<Object> get props => super.props..add(listing);
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