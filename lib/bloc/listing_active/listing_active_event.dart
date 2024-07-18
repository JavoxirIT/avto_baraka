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

class ListingActiveDeleteEvent extends ListingActiveEvent {
  const ListingActiveDeleteEvent({
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

class ListingAvtiveChangePriceEvent extends ListingActiveEvent {
  const ListingAvtiveChangePriceEvent({
    required this.id,
    required this.value,
    required this.lang,
    required this.token,
  });
  final int id;
  final String value;
  final String lang;
  final String token;

  @override
  List<Object> get props => super.props..addAll([id]);
}
