import 'package:flutter/material.dart';
import 'package:online_classroom/screens/screens.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  var currInd = 0;

  final List<Widget> classScreens = [
    ClassStreamScreen(),
    ClassClassworkScreen(),
    ClassPeopleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Globals.kBackButton,
        title: currInd == 0
            ? null
            : Text(
                'Class Name',
                style: Globals.kHeading1Style,
              ),
      ),
      body: classScreens[currInd],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            currInd = i;
          });
        },
        currentIndex: currInd,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_outlined),
            label: 'Classwork',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'People',
          ),
        ],
      ),
    );
  }
}
