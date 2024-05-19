part of 'listing_bloc.dart';

@immutable
sealed class ListingEvent {
  const ListingEvent();

  @override
  List<Object> get props => [];
}

class ListingEventLoad extends ListingEvent {
  const ListingEventLoad(this.lang, this.token);
  final String? lang;
  final String? token;

  @override
  List<Object> get props => super.props..addAll([lang!, token!]);
}
