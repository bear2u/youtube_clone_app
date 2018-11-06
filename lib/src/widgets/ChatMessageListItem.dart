import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';

var currentUserEmail;

class ChatMessageListItem extends StatelessWidget {

  ChatData chatData;

  ChatMessageListItem({this.chatData}) : assert(chatData != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          chatData.isMine
            ? getSendMessageLayout()
            : getReceivedMessageLayout()
    );
  }

  getSendMessageLayout() {
    return <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.only(top: 10.0, right: 10.0),
            child: _buildChat(chatData.chatContent),
            alignment: Alignment.bottomRight,
          ),
        ),
    ];
  }

  getReceivedMessageLayout() {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/man.png"),
            ),
          )
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(chatData.name,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: _buildChat(chatData.chatContent),
            )
          ],
        ),
      )
    ];
  }

  _buildChat(String text) {
    return PhysicalModel(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(25.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(text),
      ),
    );
  }
}