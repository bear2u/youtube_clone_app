import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/UserData.dart';

import 'package:youtube_clone_app/src/tabs/youtubeScreen.dart';
import 'package:youtube_clone_app/src/commons/colors.dart';


import 'package:youtube_clone_app/src/tabs/NearByScreen.dart';
import 'package:youtube_clone_app/src/tabs/ChatScreen.dart';
import 'package:youtube_clone_app/src/utils/fb_api_provider.dart';



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{

  var _tabIndex = 0;
  final List<Widget> _tabs = [YoutubeScreen(), ChatScreen(), NearByScreen()];
  final fbApiProvider = FbApiProvider();

  //TabBar
  //AppBar

  UserData userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleSignIn();
  }

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              width: double.maxFinite,
              child: Text(
                "Flutter Study App",
                style: TextStyle(color: AppBarColor),
              ),
            ),
          ),
          _getProfileCircleImage()
        ],
      ),
      backgroundColor: AppBackgroundColor,
    );
  }

  _getProfileCircleImage() {
    return InkWell(
      onTap: () {
        userData == null
        ? _handleSignIn()
        : _showSignOutDialog();
      },
      child: new Container(
        width: 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: const Color(0xff7c94b6),
          image: new DecorationImage(
            image: userData == null
              ? new AssetImage("assets/images/profile.png")
              : new NetworkImage(userData.photoUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),
      ),
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

  _handleSignIn() {
    fbApiProvider.handleSignIn()
        .then((UserData userData) {
          print(userData);
          setState(() {
            this.userData = userData;
          });
        });
  }

  _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("로그아웃 하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text("로그아웃"),
              onPressed: () {
                Navigator.of(context).pop();
                fbApiProvider.signOutProc()
                    .then((dynamic result) {
                      setState(() {
                        userData = null;
                      });
                    });
              },
            ),
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}
