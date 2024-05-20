part of 'listing_active_bloc.dart';

sealed class ListingActiveState extends Equatable {
  const ListingActiveState();

  @override
  List<Object> get props => [];
}

final class ListingActiveInitial extends ListingActiveState {}

final class ListingActiveNotData extends ListingActiveState {}

//
final class ListingActiveStateLoad extends ListingActiveState {
  const ListingActiveStateLoad({
    required this.listing,
  });
  final List<ListingGetModals> listing;

  @override
  List<Object> get props => super.props..add(listing);
}

// ошибка при получение данных
final class ListingActiveStateError extends ListingActiveState {
  const ListingActiveStateError({
    required this.exception,
  });
  final Exception exception;

  @override
  List<Object> get props => super.props..add(exception);
}
