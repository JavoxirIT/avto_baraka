// ignore_for_file: file_names

import 'package:avto_baraka/generated/l10n.dart';
import 'package:flutter/material.dart';

class CreditGraphicView extends StatefulWidget {
  const CreditGraphicView({Key? key}) : super(key: key);

  @override
  CreditGraphicViewState createState() => CreditGraphicViewState();
}

class CreditGraphicViewState extends State<CreditGraphicView> {
  // ignore: prefer_typing_uninitialized_variables
  late final routeData;

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    routeData = setting.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${routeData['bankName']} ${routeData['percent']}%  ${S.of(context).tolovGrafigi}'
                .toUpperCase()),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const Column();
          }),
    );
  }
}
