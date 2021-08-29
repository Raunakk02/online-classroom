import 'dart:math';

import 'package:online_classroom/objects/objects.dart';

class ClassGroup {
  final List<String> students;
  final String teacher;
  final String name;
  final String teacherUid;
  final String sectionName;
  final String classCode;

  ClassGroup({
    List<String>? students,
    required this.teacher,
    required this.teacherUid,
    required this.name,
    required this.sectionName,
    String? classCode,
  })  : this.students = students ?? [],
        this.classCode = classCode ?? _randomClassCode(6);

  factory ClassGroup.create({
    List<String>? students,
    required AppUser teacher,
    required String name,
    required String sectionName,
    String? classCode,
  }) =>
      ClassGroup(
          teacher: teacher.name,
          teacherUid: teacher.uid,
          students: students,
          name: name,
          classCode: classCode,
          sectionName: sectionName);

  static String _randomClassCode(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  factory ClassGroup.fromJson(Map<String, dynamic> json) => ClassGroup(
        students: json['students'].cast<String>().toList(),
        teacher: json['teacher'],
        teacherUid: json['teacherUid'],
        name: json['className'],
        sectionName: json['sectionName'],
        classCode: json['classCode'],
      );

  Map<String, dynamic> toJson() => {
        'students': this.students,
        'teacher': this.teacher,
        'teacherUid': this.teacherUid,
        'className': this.name,
        'sectionName': this.sectionName,
        'classCode': this.classCode,
      };
}

List<ClassGroup> classGroupsFromJson(List<Map<String, dynamic>> json) {
  return json.map((e) => ClassGroup.fromJson(e)).toList();
}

List<Map<String, dynamic>> classGroupsToJson(List<ClassGroup> groups) {
  return groups.map((e) => e.toJson()).toList();
}
