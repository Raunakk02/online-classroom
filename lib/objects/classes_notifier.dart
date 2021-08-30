import 'package:flutter/foundation.dart';
import 'package:online_classroom/objects/class_group.dart';

class ClassesNotifier extends ChangeNotifier {
  final List<ClassGroup> _classes = [];

  List<ClassGroup> get value {
    List<ClassGroup> res = [];
    _classes.forEach((_class) {
      res.add(ClassGroup.fromJson(_class.toJson()));
    });
    return res;
  }

  set value(List<ClassGroup> classes) {
    _classes.clear();
    _classes.addAll(classes);
    notifyListeners();
  }
}
