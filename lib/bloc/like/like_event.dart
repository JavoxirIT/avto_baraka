part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeEvendSend extends LikeEvent {
  const LikeEvendSend({required this.id, required this.token});

  final int id;
  final String token;

  @override
  List<Object> get props => super.props..addAll([id, token]);
}

class LikeEvendGet extends LikeEvent {
  const LikeEvendGet({required this.token, required this.lang});

  final String token;
  final String lang;

  @override
  List<Object> get props => super.props..addAll([lang, token]);
}
