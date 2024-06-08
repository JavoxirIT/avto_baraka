class PaymentsResponseCardModel {
  PaymentsResponseCardModel({
    required this.status,
    required this.message,
    required this.phone,
  });
  late String status;
  late String message;
  late String phone;

  PaymentsResponseCardModel.fromMap(Map<String, dynamic> map) {
    status = map["status"] as String;
    message = map["message"] as String;
    phone = map["phone"] as String;
  }

  @override
  String toString() {
    return 'status: $status, message: $message, phone: $phone';
  }
}
