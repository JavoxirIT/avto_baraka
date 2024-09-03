import 'package:avto_baraka/api/service/user_service.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/sized_box_10.dart';
import 'package:avto_baraka/widgets/setting_list_tile.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
  final String tokenKey = 'access_token';
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
              Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
              () => Navigator.of(context).pushNamed(RouteName.settingUserView),
            ),
            sizedBox10,
            settingListTile(
              S.of(context).foydalanishShartlari,
              Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
              () => {
                Navigator.of(context).pushNamed(RouteName.termsConditionWeb)
              },
            ),
            sizedBox10,
            settingListTile(
              S.of(context).maxfiylikSiyosati,
              Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
              () => {Navigator.of(context).pushNamed(RouteName.privacyWeb)},
            ),
            sizedBox10,
            settingListTile(
              S.of(context).ilovaHaqida,
              Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
              () => {},
            ),
            const Spacer(flex: 1),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                onPressed: () {
                  TokenProvider().removeTokenPreferences(tokenKey);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.introduction,
                    (route) => false,
                  );
                },
                style: elevatedButton,
                child: Text(S.of(context).boshqaAkauntgaKirish),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                onPressed: () {
                  UserService.userService.deleteAccount();
                  TokenProvider().removeTokenPreferences(tokenKey);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.introduction,
                    (route) => false,
                  );
                },
                style: elevatedButton.copyWith(
                  backgroundColor: WidgetStatePropertyAll(colorRed),
                ),
                child: Text(S.of(context).akkauntniOchirish),
              ),
            )
          ],
        ),
      ),
    );
  }
}
