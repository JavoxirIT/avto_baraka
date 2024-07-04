import 'package:avto_baraka/api/models/chat_all_rooms_models.dart';
import 'package:avto_baraka/api/models/chat__one_room_data_models.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/redirect_to_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatService {
  static ChatService chatService = ChatService();
  static final _dio = Config.dio;
  static final _url = Config.dbMobile;

  final String tokenKey = 'access_token';
  List<ChatOneRoomModels> listChatOneRoom = [];
  List<ChatAllRoomsModale> listAllRoom = [];
  ChatOneRoomModels? map;

  Future<ChatOneRoomModels> sendChat({
    String? message,
    List<XFile>? imageFileList,
    required int userId,
  }) async {
    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry("user_id", '$userId'));
      // Добавляем изображения в FormData
      if (imageFileList != null) {
        for (int i = 0; i < imageFileList.length; i++) {
          String imageName = 'image_$i.jpg';
          formData.files.add(MapEntry(
            "imageFileList[]",
            await MultipartFile.fromFile(
              imageFileList[i].path,
              filename: imageName,
            ),
          ));
        }
      }
      if (message != null) {
        formData.fields.add(MapEntry("message", message));
      }
      final response = await _dio.post(
        '${_url}send-message',
        options: Options(
          headers: {
            'Authorization': LocalMemory.service.token,
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        // listChatOneRoom.add(ChatOneRoomModels.fromMap(response.data));
        // debugPrint('Send CMC: $response');
        map = ChatOneRoomModels.fromMap(response.data);
      } else {
        debugPrint('debugPrint: $response');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('CHAT SEND ERROR: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return map!;
  }

//  if (imageFileList != null) {
//       imageFileList.forEach((element) {
//         debugPrint('debugPrint: ${element.path}');
//       });
//     }
// Первый запрос на чат
  Future<List<ChatOneRoomModels>> getChatFirstRoom(int id) async {
    listChatOneRoom.clear();
    try {
      final response = await _dio.post(
        '${_url}all-messages-two',
        options: Options(
          headers: {
            'Authorization': LocalMemory.service.token,
          },
        ),
        data: {'user_id': id},
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          listChatOneRoom.add(ChatOneRoomModels.fromMap(element));
        }
      } else {
        debugPrint('Перый запрос error: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('ERROR Перый запрос : $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return listChatOneRoom;
  }

  // GET CHATA ROOD-ID
  Future<List<ChatOneRoomModels>> getChatOneRoom(int id) async {
    listChatOneRoom.clear();

    try {
      final response = await _dio.post(
        '${_url}all-messages',
        options: Options(
          headers: {
            'Authorization': LocalMemory.service.token,
          },
        ),
        data: {'room_id': id},
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          listChatOneRoom.add(ChatOneRoomModels.fromMap(element));
        }
        // debugPrint('One Chat rooms: ${response.data}');
      } else {
        debugPrint('response error: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('ERROR CHAT ONE ROOM: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return listChatOneRoom;
  }

  // ALL ROOMS
  Future<List<ChatAllRoomsModale>> getAllRooms() async {
    listAllRoom.clear();
    try {
      final response = await _dio.post(
        '${_url}all-rooms',
        options: Options(
          headers: {
            'Authorization': LocalMemory.service.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          listAllRoom.add(ChatAllRoomsModale.fromMap(element));
        }
        // debugPrint('ALL ROOMS: ${response.data}');
      } else {
        debugPrint('Error All Rooms : ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return listAllRoom;
  }

  Future unreadMessages() async {
    final response = await _dio.post(
      '${_url}unread-messages',
      options: Options(headers: {
        "Authorization": await LocalMemory.service.getLocolToken()
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      return data["count"];
    } else {
      if (response.statusCode == 401) {
        TokenProvider().removeTokenPreferences(tokenKey);
        redirectToLogin();
      }
      return 0;
    }
  }
}
// Response ({"id":6,"message":"salom","date":"2024-05-27 13:13:22","file":"[]","room_id":2,"user_id":7,"status":0})