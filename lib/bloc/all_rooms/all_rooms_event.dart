part of 'all_rooms_bloc.dart';

sealed class AllRoomsEvent extends Equatable {
  const AllRoomsEvent();

  @override
  List<Object> get props => [];
}

class AllRoomEventLoad extends AllRoomsEvent {}
