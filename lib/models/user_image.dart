
class UserImage {
  int id;
  String path;

  UserImage(this.id, this.path);

  factory UserImage.fromJson(Map<String, dynamic> dataMap) => UserImage(
    dataMap["id"] as int,
    dataMap["link"] as String
  );

}