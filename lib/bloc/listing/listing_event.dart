// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

part of 'listing_bloc.dart';

@immutable
sealed class ListingEvent extends Equatable {
  const ListingEvent();

  @override
  List<Object> get props => [];
}

// first list load
class ListingEventLoad extends ListingEvent {
  const ListingEventLoad();

  @override
  List<Object> get props => [];
}

class ListingEventAddListing extends ListingEvent {
  const ListingEventAddListing();

  @override
  List<Object> get props => [];
}

//REFRESH
class ListingEventRefresh extends ListingEvent {}

// PAGINATION
class ListingEventLoadMore extends ListingEvent {
  const ListingEventLoadMore({
    required this.lang,
    required this.token,
    // required this.page,
  });
  final String lang;
  final String token;
  // final int page;

  @override
  List<Object> get props => super.props..addAll([lang, token]);
}

class ListingEvantSearch extends ListingEvent {
  const ListingEvantSearch({
    required this.token,
    required this.lang,
    this.region_id,
    this.brand_id,
    this.model_id,
    this.start_year,
    this.end_year,
    this.start_price,
    this.end_price,
    this.car_type,
    this.valyuta,
  });

  final String? token;
  final String? lang;
  final region_id;
  final brand_id;
  final model_id;
  final start_year;
  final end_year;
  final start_price;
  final end_price;
  final car_type;
  final valyuta;

  @override
  List<Object> get props => super.props
    ..addAll([
      token!,
      lang!,
      region_id!,
      brand_id!,
      model_id!,
      start_year!,
      end_year!,
      start_price!,
      end_price!,
      car_type!,
      valyuta!
    ]);
}

// like

class LikeEvendSend extends ListingEvent {
  const LikeEvendSend({required this.id, required this.token});

  final int id;
  final String token;

  @override
  List<Object> get props => super.props..addAll([id, token]);
}
