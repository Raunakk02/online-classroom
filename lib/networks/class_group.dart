import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:online_classroom/networks/app_user.dart';
import 'package:online_classroom/objects/class_group.dart';
import 'package:online_classroom/objects/objects.dart';

abstract class ClassNetworks {
  static final _firestore = FirebaseFirestore.instance;
  static final _classes = FirebaseFirestore.instance.collection('classes');

  static Future<ClassGroup?> getClassGrp(String classCode) async {
    final snapshot = await _classes.doc(classCode).get();
    final data = snapshot.data();
    if (data == null) return null;
    return ClassGroup.fromJson(data);
  }

  static Future<List<ClassGroup>> getClasses(List<String> classCodes) async {
    final __futures = classCodes.map((code) => getClassGrp(code));
    final _futures = Future.wait(__futures);
    final __classes = await _futures;
    List<ClassGroup> classes = [];
    __classes.forEach((element) {
      if (element != null) classes.add(element);
    });
    return classes;
  }

  static Future<void> create(ClassGroup _class) async {
    final batch = _firestore.batch();
    batch.set(_classes.doc(_class.classCode), _class.toJson());
    await AppUserNetworks.addClassCodes(
        _class.teacherUid, [_class.classCode], batch);
    await batch.commit();
  }

  static Future<void> delete(ClassGroup _class) async {
    final batch = _firestore.batch();
    await AppUserNetworks.removeClassCodes(
        _class.teacherUid, [_class.classCode], batch);
    _class.students.forEach(
      (student) async => await AppUserNetworks.removeClassCodes(
          student, [_class.classCode], batch),
    );
    batch.delete(_classes.doc(_class.classCode));
    await batch.commit();
  }

  static Future<void> join(String user, String classCode) async {
    final _class = await getClassGrp(classCode);
    if (_class == null)
      throw PlatformException(
        code: 'class-does-not-exist',
        message: 'Class Does Not Exist',
      );
    if (_class.students.contains(user))
      throw PlatformException(
        code: 'already-student',
        message: 'You are already a Student of the Class',
      );
    if (_class.teacherUid == user)
      throw PlatformException(
        code: 'you-are-teacher',
        message: 'You are already the teacher of the Class',
      );

    final batch = _firestore.batch();
    await AppUserNetworks.addClassCodes(user, [classCode], batch);
    batch.update(_classes.doc(classCode), {
      'students': FieldValue.arrayUnion([user]),
    });
    await batch.commit();
  }

  static Future<void> unenroll(String user, String classCode) async {
    final batch = _firestore.batch();
    await AppUserNetworks.removeClassCodes(user, [classCode]);
    batch.update(_classes.doc(classCode), {
      'students': FieldValue.arrayRemove([user]),
    });
    await batch.commit();
  }
}
