import 'package:flutter/material.dart' hide CarouselController;
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/widgets/carousel/main_carousel_form_registration.dart';

List<Map<String, dynamic>> mainCarouselItem(BuildContext context) {
  return [
    {
      "id": 1,
      "image": "assets/main_image/Intro1.png",
      "text": S.of(context).ozingizgaKerakliTexnikaniQidiring
    },
    {
      "id": 2,
      "image": "assets/main_image/Intro2.png",
      "text": S.of(context).barchaParametrlariHaqidaMalumotOling
    },
    {
      "id": 3,
      "image": "assets/main_image/Intro3.png",
      "text": S.of(context).qisqaVaqtIchidaOzAvtomobilingizgaEgaBoling
    },
    {
      "id": 4,
      "image": const MainCarouselFormRegistration(),
      "text": S
          .of(context)
          .barchaImkoniyatlardanFoydalanishUchunTelefonRaqamingizOrqaliIdentifikatsiyadanOting
    },
    // {
    //   "id": 5,
    //   "image": const MainCarouselFormPay(),
    //   "text":
    //       "Tizimdan to’liq foydalanish uchun 10000 so’m miqdorida to’lov qilishingiz lozim bo’ladi"
    // }
  ];
}
