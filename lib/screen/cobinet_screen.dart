import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/car_list_data.dart';
import 'package:avto_baraka/widgets/car_card.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:flutter/material.dart';

class CobinetScreen extends StatefulWidget {
  const CobinetScreen({Key? key}) : super(key: key);

  @override
  CobinetScreenState createState() => CobinetScreenState();
}

class CobinetScreenState extends State<CobinetScreen> {
  List<Map<String, dynamic>> listNotActive =
      carList.where((element) => element['activeStatus'] == false).toList();
  List<Map<String, dynamic>> listActive =
      carList.where((element) => element['activeStatus'] != false).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 152.0,
              title: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).kabinet.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      ButtonBar(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.contactWithAdmin);
                            },
                            icon: Icon(
                              Icons.support_agent,
                              color: iconSelectedColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.settingView);
                            },
                            icon: Icon(
                              Icons.settings_outlined,
                              color: iconSelectedColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  color: backgrounColor,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      S.of(context).meningHisobim,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      "210 000 so`m",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: iconSelectedColor),
                    ),
                    trailing: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.credit_card,
                          color: iconSelectedColor,
                          size: 28.0,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ]),
              pinned: true,
              floating: true,
              bottom: TabBar(
                // tabAlignment: TabAlignment.center,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -10.0,
                  vertical: 0.0,
                ),
                // indicatorColor: iconSelectedColor,
                indicator: BoxDecoration(
                  color: iconSelectedColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
                // isScrollable: true,
                labelStyle: Theme.of(context).textTheme.displaySmall,

                tabs: [
                  Tab(text: S.of(context).tasdiqlangan),
                  Tab(text: S.of(context).bekorQilingan),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            paddingLayout(
              carCard(listActive),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: carCard(listNotActive),
            ),
          ],
        ),
      )),
    );
  }
}
