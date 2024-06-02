// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:avto_baraka/http_config/config.dart';

class ChatOneRoomModels {
  ChatOneRoomModels(
      {required this.id,
      required this.message,
      required this.date,
      required this.file,
      required this.roomId,
      required this.userId,
      required this.status,
      required this.imageList,
      required this.senderId});
  late int id;
  late String? message;
  late String date;
  late String file;
  late int roomId;
  late int userId;
  late int status;
  late int senderId;
  late List<Map<String, dynamic>> imageList;

  factory ChatOneRoomModels.fromMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> imageList = [];

    // Преобразуем строку file в список карт imageList
    List<dynamic> fileList = jsonDecode(map['file']);
    if (fileList.isNotEmpty) {
      imageList = fileList
          .map((e) => {
                'name': e.split('/').last,
                'image': '${Config.imageUrl}${e.substring(1)}'
              })
          .toList();
    }

    return ChatOneRoomModels(
      id: map['id'],
      message: map['message'],
      date: map['date'],
      roomId: map['room_id'],
      userId: map['user_id'],
      status: map['status'],
      file: map['file'],
      senderId: map['sender_id'],
      imageList: imageList,
    );
  }

  @override
  String toString() =>
      'Send Chat(id: $id, message: $message, file: $file, userId: $userId, date: $date, roomId: $roomId,  status: $status, listImage: $imageList)';
}

// Response ({"id":6,"message":"salom","date":"2024-05-27 13:13:22","file":"[]","room_id":2,"user_id":7,"status":0})