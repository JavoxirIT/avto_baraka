import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/widgets/setting_list_tile.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sozlamalar),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            settingListTile(
              S.of(context).maxsusSozlamalar,
              Theme.of(context).textTheme.bodyLarge,
              () => Navigator.of(context).pushNamed(RouteName.settingUserView),
            ),
            settingListTile(
              S.of(context).foydalanishShartlari,
              Theme.of(context).textTheme.bodyLarge,
              () => {},
            ),
            settingListTile(
              S.of(context).maxfiylikSiyosati,
              Theme.of(context).textTheme.bodyLarge,
              () => {},
            ),
            settingListTile(
              S.of(context).ilovaHaqida,
              Theme.of(context).textTheme.bodyLarge,
              () => {},
            ),
          ],
        ),
      ),
    );
  }
}
