import 'package:avto_baraka/bloc/all_rooms/all_rooms_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    BlocProvider.of<AllRoomsBloc>(context).add(AllRoomEventLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).suhbatlar)),
      body: SafeArea(child: BlocBuilder<AllRoomsBloc, AllRoomsState>(
        builder: (context, state) {
          if (state is AllRoomsStateLoad) {
            return paddingLayout(
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.listAllRooms.length,
                        itemBuilder: (context, index) {
                          final chat = state.listAllRooms[index];

                          return Card(
                            elevation: 0,
                            // color: switchBackgrounColor,
                            child: ListTile(
                              // key: chat['id'],
                              leading: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircleAvatar(
                                  backgroundColor: elevatedButtonTextColor,
                                  child: ClipOval(
                                    child: chat.messageCount > 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Badge(
                                              label: Text(
                                                chat.messageCount.toString(),
                                              ),
                                              child: Icon(
                                                Icons.chat,
                                                size: 25.0,
                                                color: colorEmber,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.chat,
                                            size: 25.0,
                                            color: colorEmber,
                                          ),
                                    // chat.messageCount > 0
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.all(10.0),
                                    //         child: Badge(
                                    //           label: Text(
                                    //               chat.messageCount.toString()),
                                    //           child: Icon(
                                    //             FontAwesomeIcons.shield,
                                    //             size: 25.0,
                                    //             color: iconSelectedColor,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : Icon(
                                    //         FontAwesomeIcons.shield,
                                    //         size: 25.0,
                                    //         color: iconSelectedColor,
                                    //       ),
                                  ),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chat.phone,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    chat.lastSmsTime!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                              // subtitle: Text(chat.lastSms != ""
                              //     ? '${chat.lastSms.substring(0, 40)}...'
                              //     : ""),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RouteName.chat,
                                  arguments: {
                                    "roomId": chat.roomId,
                                  },
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          if (state is AllRoomsNotData) {
            return const Center(
              child: Text("Xabarlar mavjut emas"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
