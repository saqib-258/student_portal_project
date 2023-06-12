class User {
  late String username;
  late String role;
  User.fromMap(Map<String, dynamic> map) {
    username = map["username"];
    role = map["role"];
  }
  User({required this.username, required this.role});
}

class UserDetail {
  String? name;
  late String username;
  late String? profilePhoto;
  UserDetail.fromMap(Map<String, dynamic> map) {
    name = map["first_name"];
    username = map["username"];
    profilePhoto = map["profile_photo"];
  }
  UserDetail({required this.username});
}
