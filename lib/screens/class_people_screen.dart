import 'package:flutter/material.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassPeopleScreen extends StatelessWidget {
  const ClassPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: Globals.kScreenPadding,
      child: Column(
        children: [
          _heading('Teacher'),
          _peopleTile('Teacher Name'),
          Globals.kSizedBox,
          _heading('Students'),
        ],
      ),
    );
  }
}

Widget _heading(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Globals.kHeading1Style,
      ),
      Divider(
        thickness: 2,
      ),
    ],
  );
}

Widget _peopleTile(String name) {
  return ListTile(
    leading: CircleAvatar(
      child: Icon(Icons.person),
    ),
    title: Text(
      name,
      style: Globals.kBodyText3Style,
    ),
  );
}
