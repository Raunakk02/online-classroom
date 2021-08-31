import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/networks.dart';
import 'package:online_classroom/objects/objects.dart';
import 'package:online_classroom/screens/screens.dart';
import 'package:online_classroom/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: ''),
      _email = TextEditingController(text: '');
  late Widget _screen;

  AppUser _appUserFromUser(User user) {
    return AppUser(
      name: user.displayName!,
      email: user.email!,
      uid: user.uid,
    );
  }

  Future<void> _uploadUser(AppUser _appUser) async {
    await showDialog(
      context: context,
      builder: (_) => FutureDialog<void>(
        future: AppUserNetworks.upload(_appUser),
        hasData: (_) => CommonAlertDialog('Successfully Updated Profile'),
      ),
    );
  }

  Widget _signUpScreen(User user) {
    _name.text = user.displayName ?? '';
    _email.text = user.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: Globals.kHeading1Style),
      ),
      body: Padding(
        padding: Globals.kScreenPadding,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                style: Globals.kBodyText1Style,
                controller: _name,
                decoration: InputDecoration(hintText: 'Enter Name'),
                validator: Globals.kCommonValidator,
              ),
              SizedBox(height: 4.w),
              TextFormField(
                style: Globals.kBodyText1Style,
                controller: _email,
                decoration: InputDecoration(hintText: 'Enter Email'),
                validator: Globals.kCommonValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            final __futures = [
              if (_name.text.isNotEmpty && user.displayName != _name.text)
                user.updateDisplayName(_name.text),
              if (_email.text.isNotEmpty && user.email != _email.text)
                user.updateEmail(_email.text),
            ];
            final _futures = Future.wait(__futures);
            await showDialog(
              context: context,
              builder: (_) => FutureDialog(
                future: _futures,
                autoClose: true,
              ),
            );
            final _appUser = _appUserFromUser(user);
            await _uploadUser(_appUser);
          },
          label: Text(
            'Submit',
            style: Globals.kBodyText2Style,
          )),
    );
  }

  @override
  void initState() {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null)
      _screen = LoginScreen();
    else if(_user.displayName == null)
      _screen = SetDisplayName();
    else if ((_user.email?.isEmpty ?? false) &&
        (_user.displayName?.isEmpty ?? false))
      _screen = _signUpScreen(_user);
    else {
      final _appUser = _appUserFromUser(_user);
      AppUserNetworks.upload(_appUser);
      _screen = HomeScreen(_appUser);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _screen;
  }
}
