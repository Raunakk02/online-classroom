import 'package:flutter/material.dart';
import 'package:online_classroom/objects/class_group.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassStreamScreen extends StatelessWidget {
  const ClassStreamScreen(this._class, {Key? key}) : super(key: key);
  final ClassGroup _class;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: Globals.kScreenPadding * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: Globals.screenWidth * 0.3,
              padding: Globals.kScreenPadding,
              decoration: BoxDecoration(
                borderRadius: Globals.kBorderRadius,
                color: Colors.deepPurpleAccent,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'class-code') {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(
                                'Class Code',
                                style: Globals.kHeading2Style,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                      child: Text(
                                    _class.classCode,
                                    style: Globals.kBodyText1Style,
                                  )),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 'class-code',
                          child: Text('Class Code'),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _class.name,
                        style: Globals.kHeading2Style,
                      ),
                      Text(
                        _class.sectionName,
                        style: Globals.kBodyText3Style,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Globals.kSizedBox,
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: Globals.kBorderRadius,
              ),
              tileColor: ColorsUtils.kElevationColor,
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
                'Share with your class',
                style: Globals.kBodyText2Style,
              ),
              onTap: () {
                //TODO: implement navigation to share with class screen
              },
            ),
            SizedBox(
              height: Globals.rawScreenHeight * 0.68,
            ),
          ],
        ),
      ),
    );
  }
}
