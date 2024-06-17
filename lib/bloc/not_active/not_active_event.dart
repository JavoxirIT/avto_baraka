part of 'not_active_bloc.dart';

sealed class NotActiveEvent extends Equatable {
  const NotActiveEvent();

  @override
  List<Object> get props => [];
}

class NotActiveEventLoad extends NotActiveEvent {
  const NotActiveEventLoad({required this.lang, required this.token});

  final String lang;
  final String token;

  @override
  List<Object> get props => super.props..add([lang, token]);
}

class NotActiveEventListingActivating extends NotActiveEvent {
  const NotActiveEventListingActivating({
    required this.id,
    required this.token,
    required this.lang,
  });

  final int id;
  final String token;
  final String lang;

  @override
  List<Object> get props => super.props..add([id, token, lang]);
}

class NotActiveEventDelete extends NotActiveEvent {
  const NotActiveEventDelete({
    required this.token,
    required this.lang,
    required this.listingId,
  });

  final String token;
  final String lang;
  final int listingId;

  @override
  List<Object> get props => super.props..add([listingId, token, lang]);
}
