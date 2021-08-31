import 'package:flutter/material.dart';
import 'package:online_classroom/objects/class_group.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassClassworkScreen extends StatelessWidget {
  const ClassClassworkScreen(this._class, {Key? key}) : super(key: key);
  final ClassGroup _class;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No classwork yet!",
        style: Globals.kBodyText3Style,
      ),
    );
  }
}
