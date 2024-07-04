import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'not_active_event.dart';
part 'not_active_state.dart';

class NotActiveBloc extends Bloc<NotActiveEvent, NotActiveState> {
  NotActiveBloc(this.listingService) : super(NotActiveInitial()) {
    on<NotActiveEventLoad>(getNotActive);
    on<NotActiveEventListingActivating>(activating);
    on<NotActiveEventDelete>(carNotActiveDelete);
  }

  final ListingService listingService;

  Future<void> getNotActive(
    NotActiveEventLoad event,
    Emitter<NotActiveState> emit,
  ) async {
    try {
      emit(NotActiveStateLoading());
      final data =
          await listingService.getNotActiveListing(event.lang, event.token);

      if (data.isEmpty) {
        emit(NotActiveStateNotData());
      } else {
        emit(NotActiveLoad(list: data));
      }
    } on Exception catch (e) {
      emit(NotActiveStateError(e));
    }
  }

  Future<void> activating(NotActiveEventListingActivating event,
      Emitter<NotActiveState> emit) async {
    final status = await listingService.postActivating(event.id, event.token);
    if (status == "success") {
      emit(NotActiveStateActivitySuccess());
      // await Future.delayed(Duration(seconds: 3));
      final listNotActive =
          await listingService.getNotActiveListing(event.lang, event.token);
      emit(NotActiveStateLoading());
      emit(NotActiveLoad(list: listNotActive));
    } else {
      emit(NotActiveStateActivityError());
      await Future.delayed(const Duration(seconds: 1));
      final listNotActive =
          await listingService.getNotActiveListing(event.lang, event.token);
      emit(NotActiveLoad(list: listNotActive));
    }
  }

  // Listing Not Activ Delete
  Future<void> carNotActiveDelete(
    NotActiveEventDelete event,
    Emitter<NotActiveState> emit,
  ) async {
    try {
      final resault =
          await listingService.deleteListing(event.listingId, event.token);

      if (resault == 1) {
        emit(NotActiveStateDeleteSuccess());
        final data =
            await listingService.getNotActiveListing(event.lang, event.token);
        if (data.isEmpty) {
          emit(NotActiveStateNotData());
        } else {
          emit(NotActiveLoad(list: data));
        }
      } else {
        emit(NotActiveStateDeleteError());
        await Future.delayed(const Duration(seconds: 1));
        final data =
            await listingService.getNotActiveListing(event.lang, event.token);
        if (data.isEmpty) {
          emit(NotActiveStateNotData());
        } else {
          emit(NotActiveLoad(list: data));
        }
      }
    } on Exception catch (exseption) {
      emit(NotActiveStateError(exseption));
    }
  }
}
