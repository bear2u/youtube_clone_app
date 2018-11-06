import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';
import 'package:youtube_clone_app/src/widgets/ChatMessageListItem.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatState();
}

//채팅 화면
class ChatState extends State<ChatScreen>{

  List<ChatData> items = [];
  TextEditingController _tec = TextEditingController();

  bool _isMine = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              color: Color(0xFFbfd1dd),
              child: _buildListItems(),
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
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => _generateItems(index)
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
                      Icons.chat,
                      color: _isMine
                        ? Theme.of(context).accentColor
                        : Colors.white
                  ),
                  onPressed: () {
                    setState(() {
                      _isMine = !_isMine;
                    });
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
        setState(() {
          items.add(
            ChatData(
                name: "aaa",
                chatContent: _tec.text,
                isMine: _isMine
            )
          );
          _tec.text = "";
        });
      },
    );
  }

  _generateItems(int index) {
    return ChatMessageListItem(chatData: items[index]);
  }
}