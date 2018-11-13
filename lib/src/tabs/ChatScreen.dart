import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';
import 'package:youtube_clone_app/src/models/UserData.dart';
import 'package:youtube_clone_app/src/utils/fb_api_provider.dart';
import 'package:youtube_clone_app/src/widgets/Bubble.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatState();
}

//채팅 화면
class ChatState extends State<ChatScreen>{

  FbApiProvider fbApiProvider = FbApiProvider();

  double _ITEM_HEIGHT = 50.0;
  List<Bubble> items = [];
  TextEditingController _tec = TextEditingController();
  ScrollController _scrollController = ScrollController();

  bool _isMe = true;

  var currentUserEmail;

  UserData userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fbApiProvider.handleSignIn()
        .then((UserData userData) {
          this.userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child:Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  child: Image.asset(
                    "assets/images/bg_whatsapp.png",
                    fit: BoxFit.fill,
                  ),
                ),
                _buildListItems()
              ],
            ),
          ),
          Divider(height: 1.0,),
          Container(
            decoration:
              BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildBottomBar(),
          )
        ],
      ),
    );
  }

  Widget _buildListItems() {
    return StreamBuilder(
      stream: Firestore.instance.collection("room").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return Text("Loading...");
          List<ChatData> list = snapshot.data.documents.map((DocumentSnapshot document) {
            return ChatData.fromMap(document);
          }).toList();
          print(list);
          return ListView.builder(
              controller: _scrollController,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) => _generateItems(list[index])
          );
        }
    );
    

  }

  Widget _buildBottomBar() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).accentColor
      ),
      child: Container(
        color: Colors.black87,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(
                      Icons.photo,
                      color: Theme.of(context).accentColor
                  ),
                  onPressed: () {
//                    setState(() {
//                      _isMe = !_isMe;
//                    });
                  }
              ),
            ),
            Flexible(
              child: TextField(
                controller: _tec,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: _getDefaultSendButton(),
            )
          ],
        ),
      ),
    );
  }

  _getDefaultSendButton() {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed: () {

        final chatData = ChatData(
          message: _tec.text,
          time: _getCurrentTime(),
          delivered: true,
          sender: userData.displayName,
          senderEmail: userData.email,
          senderPhotoUrl: userData.photoUrl
        );

        fbApiProvider.saveChat(chatData);

        _tec.text = "";


      },
    );
  }

  _generateItems(ChatData chatData) {
    return Bubble(
      message: chatData.message,
      isOthers: chatData.senderEmail == userData.email, //다른 사람일 경우 true
      time: chatData.time,
      delivered: true,
      profilePhotoUrl: chatData.senderPhotoUrl
    );
  }

  _getCurrentTime() {
    final f = new DateFormat('hh:mm');

    return f.format(new DateTime.now());
  }

}