import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_clone_app/src/models/VideoData.dart';
import 'package:youtube_clone_app/src/commons/api_key.dart';

class YoutubeFetcher {

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