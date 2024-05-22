// ignore_for_file: prefer_final_fields

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc(this._listingService) : super(LikeInitial()) {
    on<LikeEvendSend>(onChangeLike);
    on<LikeEvendGet>(getLikeList);
  }

  ListingService _listingService;

  Future<void> onChangeLike(
      LikeEvendSend event, Emitter<LikeState> emit) async {
    try {
      final response = await _listingService.onLiked(event.token, event.id);
      if (response != "1") {
        emit(LikeStateUnLiked());
      } else {
        emit(LikeStateLiked());
      }
    } on Exception catch (e) {
      emit(LikeStateError(exception: e));
    }
  }

  Future<void> getLikeList(LikeEvendGet event, Emitter<LikeState> emit) async {
    debugPrint('Like Bloc РАБОТАЕТ');

    try {
      final data = await _listingService.getLikeList(event.lang, event.token);

      if (data.isEmpty) {
        emit(LikeStateNotData());
      } else {
        emit(LikeStateData(listing: data));
      }
    } on Exception catch (e) {
      emit(LikeStateSendError(exception: e));
    }
  }
}
