import 'package:flutter/material.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassClassworkScreen extends StatelessWidget {
  const ClassClassworkScreen({Key? key}) : super(key: key);

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
