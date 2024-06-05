// ignore_for_file: public_member_api_docs, sort_constructors_first
class SendPhoneModels {
  SendPhoneModels({
    required this.message,
  });
  late String message;

  factory SendPhoneModels.fromJson(Map<String, dynamic> json) {
    return SendPhoneModels(
      message: json['message'],
    );
  }
}
