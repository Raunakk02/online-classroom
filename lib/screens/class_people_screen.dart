import 'package:flutter/material.dart';
import 'package:online_classroom/components/common_snapshot_responses.dart';
import 'package:online_classroom/networks/app_user.dart';
import 'package:online_classroom/objects/objects.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassPeopleScreen extends StatefulWidget {
  const ClassPeopleScreen(this._class, {Key? key}) : super(key: key);
  final ClassGroup _class;

  @override
  _ClassPeopleScreenState createState() => _ClassPeopleScreenState();
}

class _ClassPeopleScreenState extends State<ClassPeopleScreen> {
  late final Future<List<AppUser>> _students;

  @override
  void initState() {
    _students = AppUserNetworks.getUsers(widget._class.students);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: Globals.kScreenPadding,
      child: Column(
        children: [
          _heading('Teacher'),
          _peopleTile(widget._class.teacher),
          Globals.kSizedBox,
          _heading('Students'),
          FutureBuilder<List<AppUser>>(
            future: _students,
            builder: (_, __) => CommonAsyncSnapshotResponses<List<AppUser>>(
              __,
              builder: (users) => Column(
                mainAxisSize: MainAxisSize.min,
                children: users.map((user) => _peopleTile(user.name)).toList(),
              ),
            ),
          ),
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
