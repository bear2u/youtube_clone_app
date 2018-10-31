import 'package:flutter/material.dart';

import 'package:youtube_clone_app/src/commons/colors.dart';
import 'package:youtube_clone_app/src/commons/transparent_image.dart';
import 'package:youtube_clone_app/src/models/VideoData.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_clone_app/src/commons/api_key.dart';


class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<YoutubeScreen> with AutomaticKeepAliveClientMixin<YoutubeScreen>{

  @override
  bool get wantKeepAlive => true;

  Future<List<VideoData>> _getVideos;

  @override
  void initState() {
    print("initState");
    _getVideos = getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    super.build(context);
    return _createListBuilder();
  }

  _createListBuilder()  => FutureBuilder(
    future: _getVideos,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      switch(snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
        default :
          var list = snapshot.data;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) => _buildListItem(context, list[index])
          );
      }
    },
  );


  _buildListItem(context, video) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("clicked : $video")));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: BorderColor)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                _buildItemVideoThumbnail(video),
                _myTubeVideoContent(video)
              ],
            )
        ),
      ),
    );
  }

  _buildItemVideoThumbnail(VideoData video) => AspectRatio(
    aspectRatio: 1.8,
    child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: video.getThumbnailUrl,
        fit: BoxFit.cover
    )
  );

  /// Video Content View builder at ListView Item Widget
  _myTubeVideoContent(VideoData video) => Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.only(top: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BorderColor,
              image: DecorationImage(
                image: NetworkImage(video.getChannelData.getThumbnailUrl),
                fit: BoxFit.contain,
              )
          ),
          width: 32.0,
          height: 32.0,
        ),
        Flexible(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    video.getTitle,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: TextColor
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${video.getChannelData.getName}",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: TextColor,),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          flex: 1,
        ),
        InkWell(
            child: Container(child: Icon(Icons.more_vert, size: 20.0, color: BorderColor),),
            onTap: _modalBottomSheet,
            borderRadius: BorderRadius.circular(20.0)
        )
      ],
    ),
  );

  _modalBottomSheet() => showModalBottomSheet(
      context: context,
      builder: (builder) => Container(
        color: AppBackgroundColor,
        child: new Column(
          children: <Widget>[
            _bottomSheetListTile(Icons.not_interested, "관심 없음", () => debugPrint("관심 없음")),
            _bottomSheetListTile(Icons.access_time, "나중에 볼 동영상에 추가", () => debugPrint("나중에 볼 동영상에 추가")),
            _bottomSheetListTile(Icons.playlist_add, "재생목록에 추가", () => debugPrint("재생목록에 추가")),
            _bottomSheetListTile(Icons.share, "공유", () => debugPrint("공유")),
            _bottomSheetListTile(Icons.flag, "신고", () => debugPrint("신고")),
            Container(
              decoration: new BoxDecoration(
                  border: new Border(top: new BorderSide(color: BorderColor))
              ),
              child: _bottomSheetListTile(Icons.close, "취소", () => Navigator.pop(context)),
            )
          ],

        ),
      )
  );

  /// list tile builder for BottomSheet
  _bottomSheetListTile(IconData icon, String text, Function onTap) =>
      ListTile(
          leading: Icon(icon, color: TextColor),
          title: Text(text, style: TextStyle(color: TextColor),),
          onTap: onTap
      );

  Future<List<VideoData>> getVideos() async {
    List<VideoData> videoDataList = new List<VideoData>();
    String dataURL = "https://www.googleapis.com/youtube/v3/videos?chart=mostpopular&regionCode=KR"
        "&maxResults=20&key=$youtubeApiKey&part=snippet,contentDetails,statistics,status";

    http.Response response = await http.get(dataURL);
    dynamic resBody = json.decode(response.body);
    List videosResData = resBody["items"];

    videosResData.forEach((item) => videoDataList.add(new VideoData(item)));

    for (var videoData in videoDataList) {
      String channelDataURL = "https://www.googleapis.com/youtube/v3/channels?key=$youtubeApiKey&part=snippet&id=${videoData.getOwnerChannelId}";

      http.Response channelResponse = await http.get(channelDataURL);
      dynamic channelResBody = json.decode(channelResponse.body);

      videoData.channelDataFromJson = channelResBody["items"][0];
    }

    return videoDataList;
  }

}