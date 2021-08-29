import 'package:flutter/material.dart';
import '../utils/utils.dart';

class DrawerListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  final bool isClass;
  DrawerListTile(
      {Key? key,
      this.leading,
      required this.title,
      this.subtitle,
      this.isClass = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isClass
          ? CircleAvatar(
              radius: Globals.screenWidth * 0.04,
              backgroundColor: Colors.grey,
              child: Text(title[0]),
            )
          : leading,
      title: Text(
        title,
        style: Globals.kBodyText2Style,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}
