part of 'one_room_bloc.dart';

sealed class OneRoomEvent extends Equatable {
  const OneRoomEvent();

  @override
  List<Object> get props => [];
}

// для первого запроса на чат
class OneRoomFirstEventLoad extends OneRoomEvent {
  const OneRoomFirstEventLoad({required this.id});

  final int id;

  @override
  List<Object> get props => super.props..addAll([id]);
}

//
class OneRoomEventLoad extends OneRoomEvent {
  const OneRoomEventLoad({required this.id});
  final int id;

  @override
  List<Object> get props => super.props..addAll([id]);
}

// UPDATE CHAT
class OneRoomEventUpdate extends OneRoomEvent {
  const OneRoomEventUpdate({
    this.message,
    this.imageFileList,
    required this.userId,
    required this.currentUserId,
    required this.roomId,
  });
  final int userId;
  final int currentUserId;
  final String? message;
  final List<XFile>? imageFileList;
  final int roomId;

  @override
  List<Object> get props =>
      [userId, message ?? '', imageFileList ?? [], currentUserId];
}

class OneRoomNotificationEvent extends OneRoomEvent {
  const OneRoomNotificationEvent({
    required this.userId,
    required this.roomId,
    this.message,
    this.imageList,
  });
  final int userId;
  final int roomId;
  final String? message;
  final List<XFile>? imageList;
  @override
  List<Object> get props => [userId, message ?? '', imageList ?? []];
}
// class OneRoomEventDelete extends OneRoomEvent {
//   final String roomId;

//   OneRoomEventDelete(this.roomId);
// }
