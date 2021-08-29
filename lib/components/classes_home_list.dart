import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:random_color/random_color.dart';
import '../utils/utils.dart';

class ClassesHomeList extends StatelessWidget {
  //TODO: get classes list from server and feed them here
  const ClassesHomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (_, i) => InkWell(
        borderRadius: Globals.kBorderRadius,
        onTap: () {
          Modular.to.pushNamed(Routes.classScreen);
        },
        child: Container(
          margin: EdgeInsets.all(Globals.screenWidth * 0.03),
          padding: EdgeInsets.symmetric(vertical: 10),
          width: Globals.screenWidth * 0.8,
          height: Globals.screenWidth * 0.4,
          decoration: BoxDecoration(
            borderRadius: Globals.kBorderRadius,
            color: RandomColor().randomColor(
              colorBrightness: ColorBrightness.dark,
              colorSaturation: ColorSaturation.highSaturation,
            ),
          ),
          child: Container(
            color: Colors.black54,
            padding: EdgeInsets.all(Globals.screenWidth * 0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Class Name',
                        style: Globals.kHeading2Style,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Section Name',
                        style: Globals.kBodyText1Style,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Text(
                        'Teacher Name',
                        style: Globals.kBodyText2Style,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Unenroll'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
