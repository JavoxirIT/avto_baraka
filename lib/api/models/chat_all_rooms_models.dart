class ChatAllRoomsModale {
  late int id;
  late dynamic read;
  late int roomId;
  late int messageCount;
  late String phone;
  late String lastSms;
  late String? fullname;
  late String? lastSmsTime;
  ChatAllRoomsModale({
    required this.id,
    required this.read,
    required this.roomId,
    required this.phone,
    required this.lastSms,
    required this.fullname,
    required this.lastSmsTime,
    required this.messageCount,
  });

  ChatAllRoomsModale.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    read = map['read'];
    roomId = map['room_id'];
    phone = map['phone'];
    lastSms = map['lastSms'];
    fullname = map['fullname'];
    lastSmsTime = map['lastSmsTime'];
    messageCount = map['message_count'];
  }

  @override
  String toString() {
    return 'ChatAllRooms(id: $id, read: $read, roomId: $roomId, phone: $phone, lastSms: $lastSms, fullname: $fullname, lastSmsTime: $lastSmsTime, messageCount: $messageCount)';
  }
}
