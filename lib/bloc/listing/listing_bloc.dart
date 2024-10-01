// ignore_for_file: unused_element

import 'dart:async';
import 'dart:developer';

import 'package:avto_baraka/api/models/general_model_car.dart';
import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'listing_event.dart';
part 'listing_state.dart';

int postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc(this._listingService) : super(const ListingState()) {
    on<ListingEventLoad>(getCarListing,
        transformer: throttleDroppable(throttleDuration));
    on<ListingEvantSearch>(getSearchData);
    on<ListingEventRefresh>(getRefresh);
    on<LikeEvendSend>(onChangeLike);
    on<ListingEventAddListing>(addListing);
  }

  final ListingService _listingService;

  Future<void> getCarListing(
    ListingEventLoad event,
    Emitter<ListingState> emit,
  ) async {
    // log("state.hasReachedMax: ${state.hasReachedMax}");
    // log("state.status == ListingStatus.initial: ${state.status == ListingStatus.initial}");
    if (state.hasReachedMax) return;

    // log("state.status: ${state.status}");
    // log("ListingStatus.initial: ${ListingStatus.initial}");

    try {
      if (state.status == ListingStatus.initial) {
        GeneralModelCar listing =
            await _listingService.getDataListing(state.currentPage);
        // debugPrint('1');
        return emit(
          state.copyWith(
            status: ListingStatus.success,
            listing: listing.data,
            hasReachedMax: false,
            currentPage: listing.currentPage,
            lastPage: listing.lastPage,
          ),
        );
      }

      if (state.lastPage > state.currentPage) {
        GeneralModelCar listings =
            await _listingService.getDataListing(state.currentPage + 1);
        // if (listings.isEmpty) return;
        if (listings.data.isEmpty) {
          emit(state.copyWith(
              hasReachedMax: true, listing: List.of(state.listing)));
        } else {
          emit(state.copyWith(
            status: ListingStatus.success,
            listing: List.of(state.listing)..addAll(listings.data),
            hasReachedMax: false,
            currentPage: listings.currentPage,
          ));
        }
      }
    } on Exception catch (_) {
      // emit(ListingStateError(exception: e));
      emit(state.copyWith(status: ListingStatus.failure));
    }
  }

  Future<void> addListing(
    ListingEventAddListing event,
    Emitter<ListingState> emit,
  ) async {
    final listings = await _listingService.getDataListing(1);
    emit(state.copyWith(status: ListingStatus.initial));
    emit(state.copyWith(
      status: ListingStatus.success,
      listing: listings,
      hasReachedMax: false,
      currentPage: state.currentPage,
    ));
  }

// REFRESH
  Future<void> getRefresh(
    ListingEventRefresh event,
    Emitter<ListingState> emit,
  ) async {
    // emit( ListingStateInitial());
    try {
      emit(state.copyWith(status: ListingStatus.initial));

      // debugPrint('REFRESH: $listing');
      GeneralModelCar listing = await _listingService.getDataListing(1);

      if (listing.data.isEmpty) {
        emit(state.copyWith(
          hasReachedMax: false,
          listing: state.listing,
          status: ListingStatus.success,
        ));
      } else {
        emit(state.copyWith(
            status: ListingStatus.success,
            listing: listing.data,
            hasReachedMax: false,
            currentPage: listing.currentPage,
            lastPage: listing.lastPage));
      }
      // log("state.lastPage: ${state.lastPage}");
      //   log("state.currentPage: ${state.currentPage}");
    } catch (e) {
      emit(state.copyWith(status: ListingStatus.failure));
    }
  }

  // SEARCH
  Future<void> getSearchData(
      ListingEvantSearch event, Emitter<ListingState> emit) async {
    try {
      GeneralModelCar searchData = await _listingService.getSearchListing(
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
        event.ltype_id,
      );

      if (searchData.data.isEmpty) {
        // GeneralModelCar listings =
        //     await _listingService.getDataListing(state.currentPage);
        // emit(ListingStateNoDataSearch());
        // emit(state.copyWith(status: ListingStatus.initial));
        // ! NUJNO POKAZAT UVIDAMLENIYE CHTO OBYAVLENIYA NE NAYDENI
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
          hasReachedMax: false,
          status: ListingStatus.success,
          listing: state.listing,
          currentPage: state.currentPage,
        ));
      } else {
        emit(ListingStateHasDataSearch(count: searchData.total));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(
          state.copyWith(
            status: ListingStatus.success,
            listing: searchData.data,
            hasReachedMax: false,
            currentPage: searchData.currentPage,
            lastPage: searchData.lastPage,
          ),
        );
      }

      // emit(ListingStateLoading());
      // if (searchData.isEmpty) {
      //   emit(ListingStateNoDataSearch());
      //   await getOneListing(
      //     const ListingEventLoad(),
      //     emit,
      //   );
      // } else {
      //   emit(ListingStateHasDataSearch(count: searchData.length));
      //   await Future.delayed(const Duration(milliseconds: 500));

      //   emit(ListingState(
      //     listing: searchData,
      //     hasReachedMax: searchData.isEmpty,
      //   ));
      // }
    } on Exception catch (e) {
      emit(ListingStateError(exception: e));
    }
  }

// Like
  Future<void> onChangeLike(
      LikeEvendSend event, Emitter<ListingState> emit) async {
    try {
      final response = await _listingService.onLiked(event.token, event.id);

      List<ListingGetModels> updatedListings;

      if (response != "1") {
        updatedListings = state.listing.map((el) {
          if (el.id == event.id) {
            return ListingGetModels(
              id: el.id,
              userId: el.userId,
              activeStatus: el.activeStatus,
              brand: el.brand,
              carImage: el.carImage,
              car_body: el.car_body,
              car_position: el.car_position,
              car_type: el.car_type,
              credit: el.credit,
              description: el.description,
              discount: el.discount,
              district: el.district,
              engine: el.engine,
              expire_date: el.expire_date,
              lat: el.lat,
              long: el.long,
              mileage: el.mileage,
              model: el.model,
              posted_date: el.posted_date,
              price: el.price,
              pulling_side: el.pulling_side,
              region: el.region,
              transmission: el.transmission,
              type_of_fuel: el.type_of_fuel,
              valyuta_kurs: el.valyuta_kurs,
              valyuta_name: el.valyuta_name,
              valyuta_short: el.valyuta_short,
              viewed: el.viewed,
              year: el.year,
              phone: el.phone,
              liked: 0, // Set liked to 1
              paint_condition: el.paint_condition,
              modelImg: el.modelImg,
              topStatus: el.topStatus,
              valyutaShort: el.valyutaShort,
              price_foiz: el.price_foiz,
              min_price: el.min_price,
              max_price: el.max_price,
            );
          }
          return el;
        }).toList();
      } else {
        updatedListings = state.listing.map((el) {
          if (el.id == event.id) {
            return ListingGetModels(
              id: el.id,
              userId: el.userId,
              activeStatus: el.activeStatus,
              brand: el.brand,
              carImage: el.carImage,
              car_body: el.car_body,
              car_position: el.car_position,
              car_type: el.car_type,
              credit: el.credit,
              description: el.description,
              discount: el.discount,
              district: el.district,
              engine: el.engine,
              expire_date: el.expire_date,
              lat: el.lat,
              long: el.long,
              mileage: el.mileage,
              model: el.model,
              posted_date: el.posted_date,
              price: el.price,
              pulling_side: el.pulling_side,
              region: el.region,
              transmission: el.transmission,
              type_of_fuel: el.type_of_fuel,
              valyuta_kurs: el.valyuta_kurs,
              valyuta_name: el.valyuta_name,
              valyuta_short: el.valyuta_short,
              viewed: el.viewed,
              year: el.year,
              phone: el.phone,
              liked: 1, // Set liked to 1
              paint_condition: el.paint_condition,
              modelImg: el.modelImg,
              topStatus: el.topStatus,
              valyutaShort: el.valyutaShort,
              price_foiz: el.price_foiz,
              min_price: el.min_price,
              max_price: el.max_price,
            );
          }
          return el;
        }).toList();
      }

      emit(state.copyWith(
        status: ListingStatus.success,
        listing: updatedListings,
        hasReachedMax: false,
        currentPage: state.currentPage,
      ));
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint('Exception: $e');
    }
  }
}
