
class ChatData {
  final String id;
  final String message;
  final String time;
  final bool delivered;
  final bool isYours;

  ChatData({
    this.id,
    this.message,
    this.time,
    this.delivered,
    this.isYours
  }) : assert(message != null);

  Map<String, dynamic> toMap() {
    return <String,dynamic>{
      "id": id,
      "message": message,
      "time": time,
      "delivered": delivered,
      "isYours": isYours
    };
  }
}