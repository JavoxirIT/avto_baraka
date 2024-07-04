// ignore_for_file: prefer_final_fields

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc(this._listingService) : super(LikeInitial()) {
    on<LikeEvendGet>(getLikeList);
  }

  ListingService _listingService;

  Future<void> getLikeList(LikeEvendGet event, Emitter<LikeState> emit) async {
    try {
      final data = await _listingService.getLikeList(event.lang!, event.token!);

      emit(LikeInitial());
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
