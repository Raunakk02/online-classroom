import 'package:online_classroom/networks/app_user.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  List<String> classCodes;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    List<String>? classCodes,
  }) : classCodes = classCodes ?? [];

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        classCodes: json['classCodes'].cast<String>().toList(),
      );

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'email': this.email,
        'name': this.name,
        'classCodes': this.classCodes,
      };

  Future<AppUser> updateClassCodes() async {
    final _user = await AppUserNetworks.user;
    if (_user == null) return Future.value(null);
    classCodes = _user.classCodes;
    return _user;
  }
}

List<AppUser> appUserListFromJson(List<Map<String, dynamic>> json) {
  return json.map((e) => AppUser.fromJson(e)).toList();
}

List<Map<String, dynamic>> appUserListToJson(List<AppUser> users) {
  return users.map((e) => e.toJson()).toList();
}
