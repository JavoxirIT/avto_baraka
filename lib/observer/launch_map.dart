import 'package:url_launcher/url_launcher.dart';

launchMap(double latitude, double longitude) async {
  final googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  final yandexMapsUrl = "yandexmaps://maps.yandex.ru/?ll=$longitude,$latitude";
  final fallbackUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl));
  } else if (await canLaunchUrl(Uri.parse(yandexMapsUrl))) {
    await launchUrl(Uri.parse(yandexMapsUrl));
  } else {
    await launchUrl(Uri.https(fallbackUrl));
  }
}
