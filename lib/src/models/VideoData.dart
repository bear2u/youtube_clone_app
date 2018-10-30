import './ChannelData.dart';

class VideoData {
  String ownerChannelId;
  String thumbnailUrl;
  String title;
  String viewCount;
  String publishDate;
  ChannelData channelData;

  /// Video Data Constructor
  VideoData(Map videoJsonData) {
    this.ownerChannelId = videoJsonData["snippet"]["channelId"];
    this.thumbnailUrl = videoJsonData["snippet"]["thumbnails"]["high"]["url"];
    this.title = videoJsonData["snippet"]["title"];
    this.viewCount = videoJsonData["statistics"]["viewCount"];
    this.publishDate = videoJsonData["snippet"]["publishedAt"];
  }

  /// Video Data unnamed Constructor
  VideoData.includeChannelData(Map videoJsonData, Map channelJsonData) {
    VideoData(videoJsonData);
    this.channelData = ChannelData(channelJsonData);
  }

  set channelDataFromJson(Map channelJsonData) {
    this.channelData = new ChannelData(channelJsonData);
  }

  get getOwnerChannelId => this.ownerChannelId;

  get getThumbnailUrl => this.thumbnailUrl;

  get getTitle => this.title;

  get getViewCount => this.viewCount;

  get getPublishedDate => this.publishDate;

  get getChannelData => this.channelData;
}