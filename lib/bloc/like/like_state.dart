part of 'like_bloc.dart';

sealed class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

final class LikeInitial extends LikeState {}

final class LikeStateNotData extends LikeState {}

final class LikeStateData extends LikeState {
  const LikeStateData({
    required this.listing,
  });
  final List<ListingGetModels> listing;

  @override
  List<Object> get props => super.props..add(listing);
}

final class LikeStateError extends LikeState {
  const LikeStateError({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => super.props..add(exception);
}

final class LikeStateSendError extends LikeState {
  const LikeStateSendError({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => super.props..add(exception);
}
