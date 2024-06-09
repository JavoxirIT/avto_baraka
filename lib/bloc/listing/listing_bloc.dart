// ignore_for_file: unused_element

import 'dart:async';

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:avto_baraka/api/service/listing_service.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc(this._listingService) : super(ListingStateInitial()) {
    on<ListingEventLoad>(getOneListing);
    on<ListingEventLoadMore>(_onListingLoadMore);
    on<ListingEvantSearch>(getSearchData);
    on<ListingEventRefresh>(getRefresh);
  }

  final ListingService _listingService;

  Future<void> getOneListing(
      ListingEventLoad event, Emitter<ListingState> emit) async {
    try {
      final listing =
          await _listingService.getDataListing(event.lang, event.token, 1);

      if (listing.isEmpty) {
        emit(ListingStateNoData());
      } else {
        emit(ListingStateLoading());
        emit(
          ListingStateLoad(
            listing: listing,
            currentPage: 1,
            hasReachedMax: listing.isEmpty,
          ),
        );
      }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    } finally {
      // emit(ListingStateRefresh(complater));
    }
  }

// REFRESH
  Future<void> getRefresh(
    ListingEventRefresh event,
    Emitter<ListingState> emit,
  ) async {
    emit(ListingStateInitial());
    try {
      final listing =
          await _listingService.getDataListing(event.lang, event.token, 1);

      if (listing.isEmpty) {
        emit(ListingStateNoData());
      } else {
        emit(ListingStateLoading());
        emit(
          ListingStateLoad(
            listing: listing,
            currentPage: 1,
            hasReachedMax: listing.isEmpty,
          ),
        );
      }
    } catch (e) {
      debugPrint('debugPrint: $e');
    }
  }

  // PAGINATION
  Future<void> _onListingLoadMore(
      ListingEventLoadMore event, Emitter<ListingState> emit) async {
    if (state is ListingStateLoad) {
      final currentState = state as ListingStateLoad;
      final currentListings = currentState.listing;
      // final nextPage = currentState.currentPage + 1;

      try {
        final listing = await _listingService.getDataListing(
          event.lang,
          event.token,
          event.page,
        );
        if (listing.isEmpty) {
          return;
        } else {
          emit(ListingStateLoad(
            listing: currentListings + listing,
            currentPage: event.page,
            hasReachedMax: listing.isEmpty,
          ));
        }
      } on Exception catch (e) {
        emit(ListingStateError(exception: e));
      }
    }
  }

  // SEARCH
  Future<void> getSearchData(
      ListingEvantSearch event, Emitter<ListingState> emit) async {
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
      // emit(ListingStateLoading());
      if (searchData.isEmpty) {
        emit(ListingStateNoDataSearch());
        await getOneListing(
          ListingEventLoad(
            event.lang,
            event.token,
          ),
          emit,
        );
      } else {
        emit(ListingStateHasDataSearch(count: searchData.length));
        await Future.delayed(const Duration(milliseconds: 500));

        emit(ListingStateLoad(
          listing: searchData,
          currentPage: 1,
          hasReachedMax: searchData.isEmpty,
        ));
      }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    }
  }
}
