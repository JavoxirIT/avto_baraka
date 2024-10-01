// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'listing_bloc.dart';

enum ListingStatus { initial, success, failure }

class ListingState extends Equatable {
  const ListingState({
    this.status = ListingStatus.initial,
    this.listing = const <ListingGetModels>[],
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.count = 0,
    this.lastPage = 0
  });
  final ListingStatus status;
  final List<ListingGetModels> listing;
  final bool hasReachedMax;
  final int currentPage;
  final int count;
  final int lastPage;

  ListingState copyWith({
    ListingStatus? status,
    List<ListingGetModels>? listing,
    bool? hasReachedMax,
    int? currentPage,
    int? count,
    int? lastPage,
  }) {
    return ListingState(
      status: status ?? this.status,
      listing: listing ?? this.listing,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      count: count ?? this.count,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [listing, status, hasReachedMax];
}

final class ListingStateInitial extends ListingState {}

final class ListingStateLoading extends ListingState {}

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

  final  int count;

  @override
  List<Object> get props => super.props..add(count);
}

// on refresh
final class ListingStateRefresh extends ListingState {
  const ListingStateRefresh(
    this.complater,
  );
  final Completer? complater;
}

final class ListingStateUnLiked extends ListingState {}

final class ListingStateLiked extends ListingState {}
