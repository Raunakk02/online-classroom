import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../utils/utils.dart';
import '../components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _showOptions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              title: Text('Create Class'),
              onTap: () {
                Modular.to.pop();
                Modular.to.pushNamed(Routes.createClass);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Join Class'),
              onTap: () {
                Modular.to.pop();
                Modular.to.pushNamed(Routes.joinClass);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Globals.kClassroomText,
        actions: [
          Padding(
            padding: Globals.kScreenPadding * 0.4,
            child: CircleAvatar(
              backgroundColor: ColorsUtils.kElevationColor,
              foregroundColor: ColorsUtils.kTextColor,
              child: Text(
                FirebaseAuth.instance.currentUser!.email![0],
                style: Globals.kBodyText1Style,
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(
        classes: [
          'Ada',
          'BCCS-2031',
          'ISS',
        ],
      ),
      body: ClassesHomeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showOptions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
