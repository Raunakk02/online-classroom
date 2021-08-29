import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/components.dart';
import '../utils/utils.dart';

class CustomDrawer extends StatefulWidget {
  final List<String>? classes;
  const CustomDrawer({Key? key, this.classes}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // static final navigationKey = locator<NavigationService>().navigatorKey;
  List drawerItems = [
    DrawerListTile(
      leading: Icon(Icons.home),
      title: 'Classes',
      subtitle: null,
      onTap: () {
        Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      },
    ),
    DrawerListTile(
      leading: Icon(Icons.calendar_today_outlined),
      title: 'Calendar',
      subtitle: null,
      onTap: () {},
    ),
    Divider(),
    DrawerListTile(
      leading: Icon(Icons.logout_rounded),
      title: 'Logout',
      subtitle: null,
      onTap: FirebaseAuth.instance.signOut,
    ),
  ];

  @override
  void initState() {
    if (widget.classes != null && widget.classes!.length > 0) {
      drawerItems.insertAll(
        3,
        [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Enrolled"),
          ),
          DrawerListTile(
            leading: Icon(Icons.note_alt),
            title: 'To-do',
            subtitle: null,
            onTap: () {},
          ),
          ...widget.classes!
              .map((e) => DrawerListTile(
                    title: e,
                    isClass: true,
                    onTap: () {
                      //TODO: implement navigation to class screens
                    },
                  ))
              .toList(),
          Divider(),
        ],
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ListTile(
              title: Globals.kClassroomText,
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => drawerItems[i],
              itemCount: drawerItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
