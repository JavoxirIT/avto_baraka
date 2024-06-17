import 'package:avto_baraka/provider/chat/chat.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';

class ChatController with ChangeNotifier {
  final List<Chat> _chatList = [];
  List<Chat> get chatList => _chatList;
  void addChat(Chat chat) {
    _chatList.add(chat);
    notifyListeners();
  }
}
