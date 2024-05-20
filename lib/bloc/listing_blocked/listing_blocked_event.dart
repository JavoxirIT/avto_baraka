part of 'listing_blocked_bloc.dart';

sealed class ListingBlockedEvent extends Equatable {
  const ListingBlockedEvent();

  @override
  List<Object> get props => [];
}

class ListingBlockedEventLoad extends ListingBlockedEvent {
  const ListingBlockedEventLoad(this.lang, this.token);
  final String? lang;
  final String? token;

  @override
  List<Object> get props => super.props..addAll([lang!, token!]);
}
