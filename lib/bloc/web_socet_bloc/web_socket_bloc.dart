import 'dart:async';
import 'dart:convert';

import 'package:avto_baraka/api/service/chat_servive.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/provider/notification_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

part 'web_socket_event.dart';
part 'web_socket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  final NotificationService notificationService;
  final ChatService chatService;
  WebSocketBloc(
    this.notificationService,
    this.chatService,
  ) : super(WebSocketInitial()) {
    on<ConnectWebSocket>(_onConnectWebSocket);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    // on<DisconnectWebSocket>(_onDisconnectWebSocket);
  }
  Stream<WebSocketState> get stateStream => stream; // Поток состояний

  void _onConnectWebSocket(
      ConnectWebSocket event, Emitter<WebSocketState> emit) async {
    emit(WebSocketConnecting());
    debugPrint('Connecting to WebSocket: ${event.url}');

    try {
      _channel = WebSocketChannel.connect(Uri.parse(event.url));
       debugPrint('WebSocket connected successfully');
      _subscription = _channel!.stream.listen((data) {
        final message = jsonDecode(data);

        LocalMemory.service.getLocolUserId();
        add(ReceiveMessage(
            message: message['message'],
            id: message['id'],
            currentUserId: message['currentUserId'],
            imageList: message['imageFileList'] ?? [],
            roomId: message['roomId']));
      }, onDone: () {
        debugPrint('_onConnectWebSocket: Connection closed');
        add(DisconnectWebSocket());
      }, onError: (error) {
        debugPrint('_onConnectWebSocket: Error - $error');
        add(DisconnectWebSocket());
      });

      emit(WebSocketConnected());
    } catch (e) {
      debugPrint('_onConnectWebSocket: Exception - $e');
      emit(WebSocketError(e.toString()));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<WebSocketState> emit) {
    try {
      final dataJson = jsonEncode({
        "id": event.id,
        "message": event.message,
        "currentUserId": event.currentUserId,
        "imageFileList": event.imageFileList,
        "roomId": event.roomId
      });
      _channel?.sink.add(dataJson);

      debugPrint('event.id: ${event.id}');
    } catch (e) {
      debugPrint('WebSocket SendMessage: $e');
    }
  }

// Чтение сообщения из socket
  void _onReceiveMessage(ReceiveMessage event, Emitter<WebSocketState> emit) {
    try {
      emit(WebSocketMessageReceived(
        id: event.id,
        message: event.message,
        rootId: event.currentUserId,
        imageList: event.imageList,
        roomId: event.roomId,
      ));

      // debugPrint('ReceiveMessage: ${event.id}');

      if (event.id == int.parse(LocalMemory.service.userId)) {
        //  debugPrint('notificationService');
        notificationService.showNotification(0, "Avto Baraka", event.message);
      }
    } catch (e) {
      debugPrint('WebSocket _onReceiveMessage: $e');
    }
  }

  // void _onDisconnectWebSocket(
  //     DisconnectWebSocket event, Emitter<WebSocketState> emit) async {
  //   try {
  //     await _channel?.sink.close(status.goingAway);
  //     await _subscription?.cancel();
  //     _channel = null;
  //     _subscription = null;
  //     emit(WebSocketDisconnected());
  //   } catch (e) {
  //     debugPrint('_onDisconnectWebSocket: Exception - $e');
  //     emit(WebSocketError(e.toString()));
  //   }
  // }

  @override
  Future<void> close() {
    try {
      debugPrint('close: Closing WebSocket');
      _channel?.sink.close(status.goingAway);
      _subscription?.cancel();
    } catch (e) {
      debugPrint('close: Exception - $e');
    }
    return super.close();
  }
}
