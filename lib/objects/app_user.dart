import 'package:online_classroom/objects/objects.dart';

class AppUser {
  final String uid;
  final String email;
  List<String> classCodes;

  AppUser({
    required this.uid,
    required this.email,
    required this.classCodes,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'],
        email: json['email'],
        classCodes: json['classCodes'],
      );

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'email': this.email,
        'classCodes': this.classCodes,
      };
}

List<AppUser> appUserListFromJson(List<Map<String, dynamic>> json) {
  return json.map((e) => AppUser.fromJson(e)).toList();
}

List<Map<String, dynamic>> appUserListToJson(List<AppUser> users) {
  return users.map((e) => e.toJson()).toList();
}
