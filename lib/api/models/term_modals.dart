import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TermModels {
  TermModels({
    required this.id,
    required this.term,
    required this.termNameUz,
    required this.termNameRu,
  });

  late int id;
  late int term;
  late String termNameUz;
  late String termNameRu;
  late bool isCheck;
  late int isCheckId;

  TermModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    term = map['term'];
    termNameUz = map['termNameUz'];
    termNameRu = map['termNameRu'];
    isCheck = false;
    isCheckId = -1;
  }
}
