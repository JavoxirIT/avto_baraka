class GeneralPoginationLinkModels {
  final String? url;
  final String label;
  final bool active;

  GeneralPoginationLinkModels({
    this.url,
    required this.label,
    required this.active,
  });

  factory GeneralPoginationLinkModels.fromMap(Map<String, dynamic> json) {
    return GeneralPoginationLinkModels(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
