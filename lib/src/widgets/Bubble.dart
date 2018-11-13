import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/models/ChatData.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isOthers, this.profilePhotoUrl, this.imageUrl});

  final String message, time, profilePhotoUrl, imageUrl;
  final delivered, isOthers;

  @override
  Widget build(BuildContext context) {
    final bg = isOthers ? Colors.white : Colors.greenAccent.shade100;
    final align = isOthers ? MainAxisAlignment.start : MainAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isOthers
        ? BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
      bottomRight: Radius.circular(10.0),
    );
    return Row(
      mainAxisAlignment: align,
      children: <Widget>[
        _getCircleProfileIcon(),
        Container(
          //margin: const EdgeInsets.all(3.0),
          margin: isOthers
            ? EdgeInsets.only(top: 50.0, left: 3.0, bottom: 3.0, right: 3.0)
            : EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: message != null
                  ? Text(message)
                  : Image.network(imageUrl, width: 100.0,)
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _getCircleProfileIcon() {
    if(!isOthers) {
      return Container();
    }
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: new NetworkImage(profilePhotoUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      ),
    );
  }
}