import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/language.dart';
import 'package:avto_baraka/view/setting_view/language_setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  SettingViewState createState() => SettingViewState();
}

class SettingViewState extends State<SettingView> {
  int languageGroupValue = -1;
  SharedPreferences? _prefs;
  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sozlamalar),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).til.toUpperCase(),
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: lang.length,
                itemBuilder: (context, index) {
                  final language = lang[index];
                  return RadioListTile(
                    tileColor: backgnColStepCard,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => iconSelectedColor),
                    shape: shape,
                    // contentPadding: const EdgeInsets.all(0),
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(language["titleUz"]),
                    value: language['id'],
                    groupValue: languageGroupValue,
                    onChanged: (value) {
                      setState(() {
                        languageGroupValue = value;
                        LanguageSetting.ls.setLanguage(language["langKey"]);
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
