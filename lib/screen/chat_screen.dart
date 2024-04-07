import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/chat_list.dart';
import 'package:avto_baraka/widgets/padding_layout.dart';
import 'package:avto_baraka/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: paddingLayout(
          Column(
            children: [
              title(context, "SUHBATLAR"),
              Expanded(
                child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      final chat = chatList[index];

                      return Card(
                        elevation: 0,
                        color: switchBackgrounColor,
                        child: ListTile(
                          // key: chat['id'],
                          leading: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: chat['status'] != "admin"
                                    ? chat['smsCount'] > 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Badge(
                                              label: Text(
                                                  chat['smsCount'].toString()),
                                              child: Icon(
                                                Icons.chat,
                                                size: 25.0,
                                                color: iconSelectedColor,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.chat,
                                            size: 25.0,
                                            color: iconSelectedColor,
                                          )
                                    : chat['smsCount'] > 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Badge(
                                              label: Text(
                                                  chat['smsCount'].toString()),
                                              child: Icon(
                                                FontAwesomeIcons.shield,
                                                size: 25.0,
                                                color: iconSelectedColor,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            FontAwesomeIcons.shield,
                                            size: 25.0,
                                            color: iconSelectedColor,
                                          ),
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chat['phone'],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                chat["lastSmsTime"],
                                style: const TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                          subtitle:
                              Text('${chat["lastSms"].substring(0, 40)}...'),
                          // trailing: Text(chat["lastSmsTime"]),
                          onTap: () {
                            // print('data: click chat');
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
