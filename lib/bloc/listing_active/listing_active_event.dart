part of 'listing_active_bloc.dart';

sealed class ListingActiveEvent extends Equatable {
  const ListingActiveEvent();

  @override
  List<Object> get props => [];
}

class ListingActiveEventLoad extends ListingActiveEvent {
  const ListingActiveEventLoad(this.lang, this.token);
  final String? lang;
  final String? token;

  @override
  List<Object> get props => super.props..addAll([lang!, token!]);
}
