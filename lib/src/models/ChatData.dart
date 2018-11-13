
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  final String id;
  final String message;
  final String time;
  final bool delivered;
  final String senderEmail;
  final String sender;
  final String imgUrl;
  final String senderPhotoUrl;

  ChatData({
    this.id,
    this.message,
    this.time,
    this.delivered,
    this.sender,
    this.senderEmail,
    this.imgUrl,
    this.senderPhotoUrl
  }) : assert(message != null || imgUrl != null);

  Map<String, dynamic> toMap() {
    return <String,dynamic>{
      "id": id,
      "message": message,
      "time": time,
      "delivered": delivered,
      "sender": sender,
      "senderEmail": senderEmail,
      "imgUrl": imgUrl,
      "senderPhotoUrl": senderPhotoUrl
    };
  }

  static ChatData fromMap(DocumentSnapshot document) {
    return ChatData(
      id: document.documentID,
      message: document['message'],
      delivered: document['delivered'],
      imgUrl: document['imgUrl'],
      sender: document['sender'],
      senderEmail: document['senderEmail'],
      senderPhotoUrl: document['senderPhotoUrl'],
      time: document['time']
    );
  }

  @override
  String toString() {
    return 'ChatData{id: $id, message: $message, time: $time, delivered: $delivered, senderEmail: $senderEmail, sender: $sender, imgUrl: $imgUrl, senderPhotoUrl: $senderPhotoUrl}';
  }


}