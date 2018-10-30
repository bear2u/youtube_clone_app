import 'package:flutter/material.dart';

import 'package:youtube_clone_app/src/tabs/youtubeScreen.dart';
import 'package:youtube_clone_app/src/commons/colors.dart';


import 'package:youtube_clone_app/src/tabs/NearByScreen.dart';
import 'package:youtube_clone_app/src/tabs/ChatScreen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{

  var _tabIndex = 0;
  final List<Widget> _tabs = [YoutubeScreen(), ChatScreen(), NearByScreen()];

  //TabBar
  //AppBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildMatchAppbar(context),
      body: _tabs[_tabIndex],
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildMatchAppbar(context) {
    return AppBar(
      title: Text(
          "Flutter Study App",
          style: TextStyle(color: AppBarColor),
      ),
      backgroundColor: AppBackgroundColor,
    );
  }

  _buildBottomNavigationBar(context) => Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppBackgroundColor,
        primaryColor: BottomNaviItemSelectedColor,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: BottomNaviItemColor),
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(
          color: BottomNaviItemColor
        )),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem(Icons.videocam, "youtube"),
          _bottomNavigationBarItem(Icons.chat, "chat"),
          _bottomNavigationBarItem(Icons.map, "nearby")
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (int index) {
          print(index);
          setState(() {
            _tabIndex = index;
          });
        },
      ));

  BottomNavigationBarItem _bottomNavigationBarItem(IconData icon, String text) {
    return new BottomNavigationBarItem(icon: Icon(icon), title: Text(text));
  }
}
