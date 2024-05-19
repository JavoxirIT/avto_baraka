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
  }

  final ListingService _listingService;

  Future<void> getListingProvider(
      ListingEventLoad event, Emitter<ListingState> emit) async {
    debugPrint('Bloc работает: ${event.lang}');

    try {
      final listing = await _listingService.getDataListing(event.lang, event.token);
      if (listing.isEmpty) {
        emit(ListingStateNoData());
      } else {
        emit(ListingStateLoad(listing: listing));
      }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    }
  }
}
