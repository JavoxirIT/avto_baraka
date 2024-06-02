// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chat {
  final int id;
  final String message;
  final String date;
  final String file;
  final int roomId;
  final int userId;
  final int status;
  
  Chat({
    required this.id,
    required this.message,
    required this.date,
    required this.file,
    required this.roomId,
    required this.userId,
    required this.status,
  });
}


//  {id: 28, message: q, date: 2024-05-28 07:36:46, file: [], room_id: 3, user_id: 5, status: 0}