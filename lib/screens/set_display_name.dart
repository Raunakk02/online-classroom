import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/app_user.dart';
import 'package:online_classroom/utils/utils.dart';

class SetDisplayName extends StatefulWidget {
  const SetDisplayName({Key? key}) : super(key: key);

  @override
  _SetDisplayNameState createState() => _SetDisplayNameState();
}

class _SetDisplayNameState extends State<SetDisplayName> {
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Enter Your Name'),
        centerTitle: true,
      ),
      body: Padding(
        padding: Globals.kScreenPadding,
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              style: Globals.kBodyText1Style,
              controller: _userName,
              decoration: InputDecoration(hintText: 'Enter Your Name'),
              validator: Globals.kCommonValidator,
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
                future: AppUserNetworks.assignDisplayNameToUser(
                    _userName.text.trim()),
                autoClose: true,
              ),
            );

            if (successful ?? false)
              Modular.to.pushNamedAndRemoveUntil(
                Routes.authState,
                (_) => true,
              );
          },
          label: Text(
            'Submit',
            style: Globals.kBodyText3Style,
          )),
    );
  }
}
