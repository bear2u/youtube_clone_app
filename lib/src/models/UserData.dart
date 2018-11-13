class UserData {
  final id;
  var email;
  var photoUrl;
  var displayName;

  UserData({this.id, this.email, this.photoUrl, this.displayName});

  @override
  String toString() {
    return 'UserData{id: $id, email: $email, photoUrl: $photoUrl}';
  }

}
