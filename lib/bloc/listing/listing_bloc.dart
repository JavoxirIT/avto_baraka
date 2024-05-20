import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:avto_baraka/api/service/listing_service.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc(this._listingService) : super(ListingStateInitial()) {
    on<ListingEventLoad>(getListingProvider);
    on<ListingEvantSearch>(getSearchData);
  }

  final ListingService _listingService;

  Future<void> getListingProvider(
      ListingEventLoad event, Emitter<ListingState> emit) async {
    try {
      final listing =
          await _listingService.getDataListing(event.lang, event.token);

      if (listing.isEmpty) {
        emit(ListingStateNoData());
      } else {
        emit(ListingStateLoading());
        emit(ListingStateLoad(listing: listing));
      }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    }
  }

  Future<void> getSearchData(
      ListingEvantSearch event, Emitter<ListingState> emit) async {
    debugPrint('debugPrint');

    try {
      final searchData = await _listingService.getSearchListing(
        event.lang,
        event.token,
        event.brand_id,
        event.car_type,
        event.end_price,
        event.end_year,
        event.model_id,
        event.region_id,
        event.start_price,
        event.start_year,
        event.valyuta,
      );
      emit(ListingStateLoading());
      if (searchData.isEmpty) {
        emit(ListingStateNoDataSearch());
         await getListingProvider(
           ListingEventLoad(
             event.lang,
             event.token,
           ),
           emit,
         );
      } else {
        emit(ListingStateLoading());
        emit(ListingStateLoad(listing: searchData));
      }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    }
  }
}
