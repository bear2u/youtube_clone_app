import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';
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
    return ListView.builder(
        controller: _scrollController,
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
                      color: _isMe
                        ? Theme.of(context).accentColor
                        : Colors.white
                  ),
                  onPressed: () {
                    setState(() {
                      _isMe = !_isMe;
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
//        setState(() {
//          items.add(
//            Bubble(
//              message: _tec.text,
//              time: _getCurrentTime(),
//              delivered: true,
//              isYours: !_isMe,
//            ),
//          );
//        });

        final chatData = ChatData(
          message: _tec.text,
          time: _getCurrentTime(),
          delivered: true,
          isYours: !_isMe
        );

        fbApiProvider.saveChat(chatData);

        _tec.text = "";

//        _scrollController.addListener((){
//          print("scrolled");
//        });

//        _scrollController.jumpTo(
//            _ITEM_HEIGHT * items.length
//        );
//        _scrollController.animateTo(
//          _ITEM_HEIGHT * items.length,
//          duration: Duration(microseconds: 10),
//          curve: Curves.easeOut,
//        );

      },
    );
  }

  _generateItems(int index) {
    return items[index];
  }

  _getCurrentTime() {
    final f = new DateFormat('hh:mm');

    return f.format(new DateTime.now());
  }
}