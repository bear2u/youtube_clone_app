class ChannelData {
  String name;
  String thumbnailUrl;

  ChannelData(Map channelJsonData) {
    this.name = channelJsonData["snippet"]["title"];
    this.thumbnailUrl = channelJsonData["snippet"]["thumbnails"]["default"]["url"];
  }

  get getName => this.name;

  get getThumbnailUrl => this.thumbnailUrl;
}