import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/class_group.dart';
import 'package:online_classroom/objects/objects.dart';
import '../utils/utils.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen(this.user, {Key? key}) : super(key: key);
  final AppUser user;

  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classCode = TextEditingController(text: '');

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Globals.kScreenPadding * 1.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Ask your teacher for the class code, then enter it here.',
                  style: Globals.kBodyText1Style,
                ),
                Globals.kSizedBox,
                TextFormField(
                  style: Globals.kBodyText1Style,
                  controller: _classCode,
                  decoration: InputDecoration(
                    hintText: 'Class Code',
                  ),
                  validator: Globals.kCommonValidator,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            final successful = await showDialog<bool>(
              context: context,
              builder: (_) => FutureDialog(
                future: ClassNetworks.join(widget.user.uid, _classCode.text),
                autoClose: true,
              ),
            );

            if (successful ?? false) Modular.to.pop();
          },
          label: Text(
            'Join',
            style: Globals.kBodyText3Style,
          )),
    );
  }
}
