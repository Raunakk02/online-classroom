import 'package:flutter/material.dart';
import 'package:online_classroom/utils/utils.dart';

class ClassStreamScreen extends StatelessWidget {
  const ClassStreamScreen({Key? key}) : super(key: key);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Class Name',
                    style: Globals.kHeading2Style,
                  ),
                  Text(
                    'Section Name',
                    style: Globals.kBodyText3Style,
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
