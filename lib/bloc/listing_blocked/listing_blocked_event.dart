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

class ListingDeleteEvent extends ListingBlockedEvent {
  const ListingDeleteEvent({
    required this.listingId,
    required this.token,
    required this.lang,
  });

  final int listingId;
  final String token;
  final String lang;

  @override
  List<Object> get props => super.props..addAll([listingId, token, lang]);
}


