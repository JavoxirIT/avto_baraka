part of 'one_room_bloc.dart';

sealed class OneRoomState extends Equatable {
  const OneRoomState();

  @override
  List<Object> get props => [];
}

final class OneRoomInitial extends OneRoomState {}

final class OneRoomsNotDataState extends OneRoomState {}

final class OneRoomsLoaderState extends OneRoomState {}

final class OneRoomsLoadState extends OneRoomState {
  const OneRoomsLoadState({required this.listMessage});

  final List<ChatOneRoomModels> listMessage;

  @override
  List<Object> get props => super.props..add(listMessage);
}

final class OneRoomsErrorState extends OneRoomState {
  const OneRoomsErrorState({required this.exception});
  final Exception exception;
  @override
  List<Object> get props => super.props..add(exception);
}
