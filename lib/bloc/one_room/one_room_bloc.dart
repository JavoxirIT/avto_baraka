import 'dart:async';
import 'dart:convert';

import 'package:avto_baraka/api/models/chat__one_room_data_models.dart';
import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:avto_baraka/bloc/web_socet_bloc/web_socket_bloc.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/service/local_memory.dart';

part 'one_room_event.dart';
part 'one_room_state.dart';

class OneRoomBloc extends Bloc<OneRoomEvent, OneRoomState> {
  late StreamSubscription webSocketStateSubscription;

  OneRoomBloc(this.chatService, this.socket) : super(OneRoomInitial()) {
    on<OneRoomEventLoad>(oneRoom);
    on<OneRoomFirstEventLoad>(firstRoom);
    on<OneRoomEventUpdate>(_onOneRoomEventUpdate);

    on<OneRoomNotificationEvent>(_onOneRoomNotificationEvent);
    // on<OneRoomEventDelete>(_onOneRoomEventDelete);
    LocalMemory.service.getLocolUserId();

    // Подписываемся на состояния WebSocketBloc
    webSocketStateSubscription = socket.stream.listen((state) {
      if (state is WebSocketMessageReceived) {
        add(OneRoomNotificationEvent(
          roomId: state.roomId,
          userId: state.id,
          imageList: state.imageList,
          message: state.message,
        ));
      }
    });
  }
  final WebSocketBloc socket;
  final ChatService chatService;
  @override
  Future<void> close() {
    webSocketStateSubscription.cancel(); // Отменяем подписку при закрытии блока
    return super.close();
  }

  Future<void> oneRoom(
      OneRoomEventLoad event, Emitter<OneRoomState> emit) async {
    try {
      final listMessage = await chatService.getChatOneRoom(event.id);
      if (listMessage.isEmpty) {
        emit(OneRoomsNotDataState());
      } else {
        emit(OneRoomInitial());
        // emit(OneRoomsLoaderState());
        emit(OneRoomsLoadState(listMessage: listMessage));
      }
    } on Exception catch (e) {
      emit(OneRoomsErrorState(exception: e));
    }
  }

  Future<void> firstRoom(
      OneRoomFirstEventLoad event, Emitter<OneRoomState> emit) async {
    try {
      final listMessage = await chatService.getChatFirstRoom(event.id);
      if (listMessage.isEmpty) {
        emit(OneRoomsNotDataState());
      } else {
        emit(OneRoomInitial());
        emit(OneRoomsLoadState(listMessage: listMessage));
      }
    } on Exception catch (e) {
      emit(OneRoomsErrorState(exception: e));
    }
  }

  Future<void> _onOneRoomEventUpdate(
    OneRoomEventUpdate event,
    Emitter<OneRoomState> emit,
  ) async {
    try {
      debugPrint('event.userId: ${event.userId}');

      ChatOneRoomModels dataJson = await chatService.sendChat(
        userId: event.userId,
        message: event.message,
        imageFileList: event.imageFileList,
      );

      socket.add(SendMessage(
        message: event.message ?? "new message",
        id: event.userId,
        currentUserId: event.currentUserId,
        imageFileList: event.imageFileList,
        roomId: event.roomId,
      ));
      if (state is OneRoomsLoadState) {
        debugPrint('state is OneRoomsLoadState');
        final currentState = state as OneRoomsLoadState;
        List<ChatOneRoomModels> updatedList =
            List.from(currentState.listMessage)..add(dataJson);

        emit(OneRoomInitial());
        emit(OneRoomsLoadState(listMessage: updatedList));
      } else {
      debugPrint('dataJson.userId: ${dataJson.userId}');
        final listMessage = await chatService.getChatFirstRoom(dataJson.userId);
        emit(OneRoomsLoadState(listMessage: listMessage));
      }
    } on Exception catch (e) {
      emit(OneRoomsErrorState(exception: e));
    }
  }

  Future<void> _onOneRoomNotificationEvent(
    OneRoomNotificationEvent event,
    Emitter<OneRoomState> emit,
  ) async {
    debugPrint('РАБОТАЕТ');

    // Ваш код для уведомления
    if (event.userId == int.parse(LocalMemory.service.userId)) {
      // Отправка запроса на выполнение метода oneRoom
      add(OneRoomEventLoad(id: event.roomId));
    }
  }

  // Future<void> _onOneRoomEventDelete(
  //     OneRoomEventDelete event, Emitter<OneRoomState> emit) async {
  //   debugPrint('delete event room id: ${event.roomId}');

  //   try {
  //     await chatService.deleteChatOneRoom(event.roomId);
  //     emit(OneRoomInitial());
  //   } on Exception catch (e) {
  //     emit(OneRoomsErrorState(exception: e));
  //   }
  // }
}
