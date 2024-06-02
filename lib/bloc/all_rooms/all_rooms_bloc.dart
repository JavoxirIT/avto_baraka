import 'package:avto_baraka/api/models/chat_all_rooms_models.dart';
import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_rooms_event.dart';
part 'all_rooms_state.dart';

class AllRoomsBloc extends Bloc<AllRoomsEvent, AllRoomsState> {
  AllRoomsBloc(this.chatService) : super(AllRoomsInitial()) {
    on<AllRoomEventLoad>(allRooms);
  }

  final ChatService chatService;

  Future<void> allRooms(
      AllRoomEventLoad event, Emitter<AllRoomsState> emit) async {
    final data = await chatService.getAllRooms();

    if (data.isEmpty) {
      emit(AllRoomsNotData());
    } else {
      emit(AllRoomsInitial());
      emit(AllRoomsStateLoad(listAllRooms: data));
    }
  }
}
