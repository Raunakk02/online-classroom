import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/utils/providers.dart';
import '../components/components.dart';
import '../utils/utils.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  // static final navigationKey = locator<NavigationService>().navigatorKey;
  List drawerItems = [];

  @override
  Widget build(BuildContext context) {
    final _classes = ref.watch(classesProvider).value;
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
            child: ListView(children: [
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
              if (_classes.isNotEmpty) ...[
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
                ..._classes
                    .map((_class) => DrawerListTile(
                          title: _class.name,
                          isClass: true,
                          onTap: () {
                            Modular.to.pushNamed(Routes.classScreen,
                                arguments: _class);
                          },
                        ))
                    .toList(),
                Divider(),
              ]
            ]),
          ),
        ],
      ),
    );
  }
}
