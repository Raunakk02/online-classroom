import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/class_group.dart';
import 'package:online_classroom/objects/app_user.dart';
import 'package:online_classroom/objects/class_group.dart';
import 'package:online_classroom/utils/utils.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen(this.user, {Key? key}) : super(key: key);
  final AppUser user;

  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _className = TextEditingController(text: ''),
      _sectionName = TextEditingController(text: '');

  void _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final _class = ClassGroup.create(
      teacher: widget.user,
      name: _className.text,
      sectionName: _sectionName.text,
    );
    await showDialog(
      context: context,
      builder: (_) => FutureDialog<void>(
        future: ClassNetworks.create(_class),
        hasData: (_) => CommonAlertDialog('Successfully Created New Class'),
      ),
    );

    Modular.to.pop(context);
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Globals.kScreenPadding * 1.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Globals.kSizedBox,
                TextFormField(
                  style: Globals.kBodyText1Style,
                  controller: _className,
                  decoration: InputDecoration(hintText: 'Class Name'),
                  validator: Globals.kCommonValidator,
                ),
                Globals.kSizedBox,
                TextFormField(
                  style: Globals.kBodyText1Style,
                  controller: _sectionName,
                  decoration: InputDecoration(hintText: 'Section Name'),
                  validator: Globals.kCommonValidator,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onSubmit,
        label: Text(
          'Submit',
          style: Globals.kBodyText3Style,
        ),
      ),
    );
  }
}
