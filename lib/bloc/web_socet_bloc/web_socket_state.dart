part of 'web_socket_bloc.dart';

sealed class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object> get props => [];
}

final class WebSocketInitial extends WebSocketState {}

class WebSocketConnecting extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}

class WebSocketMessageReceived extends WebSocketState {
  const WebSocketMessageReceived({
    required this.message,
    required this.id,
    required this.rootId,
    this.imageList,
    required this.roomId,
  });

  final String message;
  final int id;
  final int rootId;
  final List<XFile>? imageList;
  final int roomId;

  @override
  List<Object> get props => [message, id, rootId, imageList ?? [], roomId];
}

class WebSocketDisconnected extends WebSocketState {}

class WebSocketError extends WebSocketState {
  const WebSocketError(this.error);

  final String error;
}
