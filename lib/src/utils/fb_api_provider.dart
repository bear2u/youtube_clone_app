
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';

/// FireStore에 연결
/// 채팅 데이터를 저장
/// 채팅 데이터를 조회
class FbApiProvider {
  static final FbApiProvider _instance = FbApiProvider.internal();

  factory FbApiProvider() => _instance;

  FbApiProvider.internal();

  /// firestore연결해서 저장
  saveChat(ChatData chatData) {
    Firestore.instance.collection("room")
        .document()
        .setData(chatData.toMap());
  }
}