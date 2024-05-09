// ignore_for_file: public_member_api_docs, sort_constructors_first
class SendPhoneModels {
  SendPhoneModels({
    required this.message,
    required this.code,
  });
  late String message;
  late int code;

  factory SendPhoneModels.fromJson(Map<String, dynamic> json) {
    return SendPhoneModels(
      message: json['message'],
      code: json['code'],
    );
  }
}
