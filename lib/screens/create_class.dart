import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/utils/utils.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({Key? key}) : super(key: key);

  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (formKey.currentState == null) return;
    formKey.currentState!.validate();
  }

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
          'Create Class',
          style: Globals.kHeading1Style,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              //TODO: implement create class functionality
              _onSubmit();
            },
            child: Text(
              'Create',
              style: Globals.kBodyText1Style,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Globals.kScreenPadding * 1.8,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Globals.kSizedBox,
                TextFormField(
                  decoration: Globals.kCustomDecoration('Class Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Cannot be blank';
                    }
                    return null;
                  },
                ),
                Globals.kSizedBox,
                TextFormField(
                  decoration: Globals.kCustomDecoration('Section Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Cannot be blank';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
