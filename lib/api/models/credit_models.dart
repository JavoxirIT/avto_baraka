class CreditData {
  final int yil;
  final PaymentDetails data;

  CreditData({required this.yil, required this.data});

  factory CreditData.fromJson(Map<String, dynamic> json) {
    return CreditData(
      yil: json['yil'],
      data: PaymentDetails.fromJson(json['data']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'yil': yil,
  //     'data': data.toJson(),
  //   };
  // }
}

class PaymentDetails {
  final int oylarSoni;
  final int oylikTulov;
  final int summaTulov;
  final int summaTulovUsd;

  PaymentDetails({
    required this.oylarSoni,
    required this.oylikTulov,
    required this.summaTulov,
    required this.summaTulovUsd,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      oylarSoni: json['oylarSoni'],
      oylikTulov: json['oylikTulov'],
      summaTulov: json['summaTulov'],
      summaTulovUsd: json['summaTulovUsd'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'oylarSoni': oylarSoni,
  //     'oylikTulov': oylikTulov,
  //     'summaTulov': summaTulov,
  //     'summaTulovUsd': summaTulovUsd,
  //   };
  // }
}
