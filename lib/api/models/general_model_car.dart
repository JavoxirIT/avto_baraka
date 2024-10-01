import 'package:avto_baraka/api/models/general_pogination_link_models.dart';
import 'package:avto_baraka/api/models/listing_get_models.dart';

class GeneralModelCar {
  final int currentPage;
  final List<ListingGetModels> data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<GeneralPoginationLinkModels> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;

  GeneralModelCar({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory GeneralModelCar.fromJson(Map<String, dynamic> json) {
    return GeneralModelCar(
      currentPage: json['current_page'],
      data: List<ListingGetModels>.from(
        json['data'].map(
          (x) => ListingGetModels.fromMap(x),
        ),
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<GeneralPoginationLinkModels>.from(
        json['links'].map(
          (x) => GeneralPoginationLinkModels.fromMap(x),
        ),
      ),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}
