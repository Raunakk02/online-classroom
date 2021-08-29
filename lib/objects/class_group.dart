import 'package:online_classroom/objects/objects.dart';

class ClassGroup {
  final List<AppUser> students;
  final AppUser teacher;
  final String className;
  final String sectionName;
  final String classCode;

  ClassGroup({
    required this.students,
    required this.teacher,
    required this.className,
    required this.sectionName,
    required this.classCode,
  });

  factory ClassGroup.fromJson(Map<String, dynamic> json) => ClassGroup(
        students: appUserListFromJson(json['students']),
        teacher: AppUser.fromJson(json['teacher']),
        className: json['className'],
        sectionName: json['sectionName'],
        classCode: json['classCode'],
      );

  Map<String, dynamic> toJson() => {
        'students': appUserListToJson(this.students),
        'teacher': this.teacher.toJson(),
        'className': this.className,
        'sectionName': this.sectionName,
        'classCode': this.classCode,
      };
}
