import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/colors.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(
      builder: (context, languageProvider, _) {
        bool langCode =
            languageProvider.locale.languageCode == "uz" ? true : false;
        return GestureDetector(
          onTap: () {
            setState(() {
              langCode = !langCode;
            });
            if (!langCode) {
              var locale = const Locale("ru");
              languageProvider.locale = locale;
              languageProvider.persistLocale("ru");
            } else {
              var locale = const Locale('uz');
              languageProvider.locale = locale;
              languageProvider.persistLocale("uz");
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: colorEmber,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: langCode ? Colors.white : colorEmber),
                    child: Center(
                        child: Text(
                      'UZ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: langCode ? Colors.black : Colors.white),
                    )),
                  ),
                  Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: langCode ? colorEmber : Colors.white),
                    child: Center(
                        child: Text(
                      'RU',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: langCode ? Colors.white : Colors.black),
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
