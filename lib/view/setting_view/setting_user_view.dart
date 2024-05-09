import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingUserView extends StatelessWidget {
  const SettingUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).maxsusSozlamalar),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Consumer<LocalProvider>(
          builder: (context, languageProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    S.of(context).til.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w900),
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  value: languageProvider.locale.languageCode,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      var locale = Locale(newValue);
                      languageProvider.locale = locale;
                      languageProvider.persistLocale(newValue);
                    }
                  },
                  items:
                      const AppLocalizationDelegate().supportedLocales.map((l) {
                    return DropdownMenuItem(
                      value: l.languageCode,
                      child: Text(
                          l.languageCode == "uz"
                              ? "O`zbek tili"
                              : "Русски язык",
                          style: Theme.of(context).textTheme.bodyLarge),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
