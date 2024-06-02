part of 'all_rooms_bloc.dart';

sealed class AllRoomsState extends Equatable {
  const AllRoomsState();

  @override
  List<Object> get props => [];
}

final class AllRoomsInitial extends AllRoomsState {}

final class AllRoomsStateLoad extends AllRoomsState {
  const AllRoomsStateLoad({required this.listAllRooms});

  final List<ChatAllRoomsModale> listAllRooms;

  @override
  List<Object> get props => super.props..add(listAllRooms);
}

final class AllRoomsNotData extends AllRoomsState {}

