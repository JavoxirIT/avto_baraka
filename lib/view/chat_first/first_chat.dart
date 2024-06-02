// ignore_for_file: unnecessary_null_comparison

import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/view/chat_first/first_chat_bottom_Item.dart';
import 'package:avto_baraka/view/chat_first/first_chat_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic_chat_bubble/flutter_basic_chat_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../api/models/chat__one_room_data_models.dart';
import '../../bloc/one_room/one_room_bloc.dart';

class FirstChat extends StatefulWidget {
  const FirstChat({Key? key}) : super(key: key);

  @override
  FirstChatState createState() => FirstChatState();
}

class FirstChatState extends State<FirstChat> {
  final scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  // int roomId = 0;
  int userId = 0;
  int _maxLines = 1;
  double _borderRadius = 50.0;

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;
    Map<String, dynamic> arguments = setting.arguments as Map<String, dynamic>;
    if (arguments != null && arguments['userId'] != null) {
      userId = arguments['userId'] as int;
      BlocProvider.of<OneRoomBloc>(context)
          .add(OneRoomFirstEventLoad(id: arguments['userId'] as int));
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateBorderRadius);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: const BorderSide(color: Colors.blue, width: 0.2),
    );

    final tokenProvider = Provider.of<TokenProvider>(context);
    final currentUserId = int.parse(tokenProvider.userId!);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: BlocBuilder<OneRoomBloc, OneRoomState>(
        builder: (context, state) {
          return Container(
            color: const Color.fromARGB(15, 0, 0, 0),
            child: Column(
              children: [
                firstChatList(context, state, currentUserId),
                firstChatBottomItItem(
                  context,
                  state,
                  borderStyle,
                  _textController,
                  onFieldSubmitted,
                  userId,
                  currentUserId
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded firstChatList(BuildContext context, state, int currentUserId) {
    return Expanded(
      child: BlocBuilder<OneRoomBloc, OneRoomState>(
        builder: (context, state) {
          // debugPrint('state: $state');

          if (state is OneRoomsLoadState) {
            List<ChatOneRoomModels> sortedMessages =
                List.from(state.listMessage);
            sortedMessages.sort((a, b) => b.id.compareTo(a.id));
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
                  reverse: true,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: sortedMessages.length,
                  itemBuilder: (context, index) {
                    final mess = sortedMessages[index];
                    final isMe = mess.userId != currentUserId;
                    return firstChatContent(isMe, context, mess, isTablet);
                  },
                ),
              ),
            );
          }
          if (state is OneRoomsLoaderState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OneRoomsNotDataState) {
            return const Center(
              child: Text("Xabar mavjut emas"),
            );
          }
          return const Center(
            child: Text("Xatolik mavjut"),
          );
        },
      ),
    );
  }

  void _updateBorderRadius() {
    int newMaxLines = _textController.text.length;
    // Логика для плавного уменьшения радиуса по мере роста количества строк
    double newBorderRadius = 50.0 - (newMaxLines + 1) / 5.0;
    if (newBorderRadius < 10.0) newBorderRadius = 10.0; // Минимальный радиус

    if (newMaxLines != _maxLines || newBorderRadius != _borderRadius) {
      setState(() {
        _maxLines = newMaxLines;
        _borderRadius = newBorderRadius;
      });
    }
  }

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      return false;
    }
    return true;
  }

  Future<void> onFieldSubmitted() async {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class ChatBubbleTriangle extends CustomPainter {
  final bool isMe;
  final Color backgroundColor;

  const ChatBubbleTriangle(this.isMe, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-10, 0);
    path.lineTo(0, 10);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
