import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/main_import.dart';
import 'package:equatable/equatable.dart';

part 'listing_active_event.dart';
part 'listing_active_state.dart';

class ListingActiveBloc extends Bloc<ListingActiveEvent, ListingActiveState> {
  ListingActiveBloc(this._listingService) : super(ListingActiveInitial()) {
    on<ListingActiveEventLoad>(getActiveListing);
    on<ListingActiveDeleteEvent>(deleteActiveListing);
    on<ListingAvtiveChangePriceEvent>(changePrice);
  }

  final ListingService _listingService;

  Future<void> getActiveListing(
      ListingActiveEventLoad event, Emitter<ListingActiveState> emit) async {
    try {
      final activeListing =
          await _listingService.getActiveDataListing(event.lang, event.token);
      if (activeListing.isEmpty) {
        emit(ListingActiveNotData());
      } else {
        emit(ListingActiveStateLoad(listing: activeListing));
      }
    } on Exception catch (e) {
      emit(ListingActiveStateError(exception: e));
    }
  }

  Future<void> deleteActiveListing(
    ListingActiveDeleteEvent event,
    Emitter<ListingActiveState> emit,
  ) async {
    try {
      final deteleResponse = await _listingService.deleteListing(
        event.listingId,
        event.token,
      );

      if (deteleResponse == 1) {
        final activeListing =
            await _listingService.getActiveDataListing(event.lang, event.token);
        if (activeListing.isEmpty) {
          emit(ListingActiveNotData());
        } else {
          // emit(ListingActiveInitial());
          emit(ListingActiveStateLoad(listing: activeListing));
        }
      }
    } on Exception catch (e) {
      emit(ListingActiveStateError(exception: e));
    }
  }

  Future<void> changePrice(ListingAvtiveChangePriceEvent event,
      Emitter<ListingActiveState> emit) async {
    try {
      final response = await _listingService.changePrice(event.id, event.value);

      if (response == 1) {
        if (state is ListingActiveStateLoad) {
          final currentState = state as ListingActiveStateLoad;
          var oneElementIndex = currentState.listing
              .indexWhere((element) => element.id == event.id);
          if (oneElementIndex != -1) {
            var updatedElement = currentState.listing[oneElementIndex].copyWith(
              price: int.parse(event.value),
            );
            List<ListingGetModals> updatedList =
                List.from(currentState.listing);
            updatedList[oneElementIndex] = updatedElement;

            emit(ListingActiveStateLoad(listing: updatedList));
            await _listingService.getDataListing(1);
          }
        }
      } else {
        emit(ListingActiveStateNotUpdatePrice());
        final activeListing =
            await _listingService.getActiveDataListing(event.lang, event.token);
        emit(ListingActiveStateLoad(listing: activeListing));
      }
    } on Exception catch (exseption) {
      debugPrint('$exseption');
    }
  }
}
