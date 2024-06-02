part of 'web_socket_bloc.dart';

sealed class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object> get props => [];
}

class ConnectWebSocket extends WebSocketEvent {
  const ConnectWebSocket({required this.url});
  final String url;
}

class SendMessage extends WebSocketEvent {
  const SendMessage({
    required this.message,
    required this.id,
    required this.currentUserId,
    this.imageFileList,
    required this.roomId,
  });
  final String message;
  final int id;
  final int currentUserId;
  final int roomId;
  final List<XFile>? imageFileList;

  @override
  List<Object> get props =>
      [message, id, currentUserId, imageFileList ?? [], roomId];
}

class ReceiveMessage extends WebSocketEvent {
  const ReceiveMessage({
    required this.message,
    required this.id,
    required this.currentUserId,
    this.imageList,
    required this.roomId,
  });

  final String message;
  final int id;
  final int currentUserId;
  final List<XFile>? imageList;
  final int roomId;

  @override
  List<Object> get props =>
      [message, id, currentUserId, imageList ?? [], roomId];
}

class DisconnectWebSocket extends WebSocketEvent {}
