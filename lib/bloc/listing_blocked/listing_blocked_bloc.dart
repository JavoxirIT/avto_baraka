import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listing_blocked_event.dart';
part 'listing_blocked_state.dart';

class ListingBlockedBloc
    extends Bloc<ListingBlockedEvent, ListingBlockedState> {
  ListingBlockedBloc(this._listingService) : super(ListingBlockedInitial()) {
    on<ListingBlockedEventLoad>(getBlockedListing);
  }

  final ListingService _listingService;

  Future<void> getBlockedListing(
      ListingBlockedEventLoad event, Emitter<ListingBlockedState> emit) async {
    try {
      final blockedList =
          await _listingService.getBlockedDataListing(event.lang, event.token);

      if (blockedList.isEmpty) {
        emit(ListingBlockedStateNotData());
      } else {
        emit(ListingBlockedInitial());
        emit(ListingBlockedStateLoad(blockedList: blockedList));
      }
    } on Exception catch (e) {
      emit(ListingBlockedStateError(exception: e));
    }
  }
}
