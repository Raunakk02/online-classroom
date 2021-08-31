import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/objects/app_user.dart';
import '../utils/utils.dart';
import '../components/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._user, {Key? key}) : super(key: key);
  final AppUser _user;

  @override
  _HomeScreenState createState() => _HomeScreenState(_user);
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget _body;
  AppUser user;

  _HomeScreenState(this.user);

  void _updateBody() {
    setState(() {
      _body = FutureBuilder<AppUser>(
        future: user.updateClassCodes(),
        builder: (_, __) => CommonAsyncSnapshotResponses<AppUser>(
          __,
          builder: (_user) {
            user = _user;
            return ClassesHomeList(user);
          },
        ),
      );
    });
  }

  void _showOptions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              title: Text('Create Class'),
              onTap: () async {
                await Modular.to.pushNamed(Routes.createClass, arguments: user);
                _updateBody();
              },
            ),
            Divider(),
            ListTile(
              title: Text('Join Class'),
              onTap: () async {
                await Modular.to.pushNamed(Routes.joinClass, arguments: user);
                _updateBody();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _body = ClassesHomeList(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Globals.kClassroomText,
        actions: [
          InkWell(
            child: Padding(
              padding: Globals.kScreenPadding * 0.4,
              child: CircleAvatar(
                backgroundColor: ColorsUtils.kElevationColor,
                foregroundColor: ColorsUtils.kTextColor,
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName![0],
                  style: Globals.kBodyText1Style,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => CommonAlertDialog(
                  "Currently signed in as",
                  content: Text(
                    'Name: ${FirebaseAuth.instance.currentUser!.displayName!}' +
                        '\nEmail: ${FirebaseAuth.instance.currentUser!.email!}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOptions(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
