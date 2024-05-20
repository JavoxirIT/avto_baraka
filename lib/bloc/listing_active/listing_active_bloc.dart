import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listing_active_event.dart';
part 'listing_active_state.dart';

class ListingActiveBloc extends Bloc<ListingActiveEvent, ListingActiveState> {
  ListingActiveBloc(this._listingService) : super(ListingActiveInitial()) {
    on<ListingActiveEventLoad>(getActiveListing);
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
}
