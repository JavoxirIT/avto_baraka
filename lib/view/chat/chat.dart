// ignore_for_file: unnecessary_null_comparison
import 'package:avto_baraka/screen/imports/imports_cabinet.dart';
import 'package:avto_baraka/view/chat/import/import_one_chat.dart';


class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
//  final int currentUserId;
  final scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  int roomId = 0;
  int _maxLines = 1;
  double _borderRadius = 50.0;

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;

    Map<String, dynamic> arguments = setting.arguments as Map<String, dynamic>;
    if (arguments != null && arguments['roomId'] != null) {
      roomId = arguments['roomId'] as int;
      BlocProvider.of<OneRoomBloc>(context).add(
        OneRoomEventLoad(id: arguments['roomId']),
      );
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
    final tokenProvider = Provider.of<TokenProvider>(context);
    final currentUserId = int.parse(tokenProvider.userId!);

    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      borderSide: const BorderSide(color: Colors.blue, width: 0.2),
    );

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
                chatList(context, currentUserId),
                chatBottomItItem(
                  context,
                  state,
                  borderStyle,
                  _textController,
                  onFieldSubmitted,
                  currentUserId,
                  roomId
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded chatList(BuildContext context, int currentUserId) {
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
                    // bool isMe = mess.senderId != 0;
                    final isMe = mess.userId != currentUserId;
                    return chatContent(isMe, context, mess, isTablet);
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
