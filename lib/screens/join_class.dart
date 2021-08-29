import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../utils/utils.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({Key? key}) : super(key: key);

  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          'Join Class',
          style: Globals.kHeading1Style,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              //TODO: implement join class functionality
            },
            child: Text(
              'Join',
              style: Globals.kBodyText1Style,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Globals.kScreenPadding * 1.8,
          child: Column(
            children: [
              Text(
                'Ask your teacher for the class code, then enter it here.',
                style: Globals.kBodyText1Style,
              ),
              Globals.kSizedBox,
              TextField(
                decoration: InputDecoration(
                  labelText: 'Class Code',
                  filled: true,
                  fillColor: ColorsUtils.kElevationColor,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
