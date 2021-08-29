import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/app_user.dart';
import 'package:online_classroom/objects/objects.dart';
import '../screens/screens.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  _AuthStateState createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  User? user;

  @override
  void initState() {
    // initDynamicLinks();
    FirebaseAuth.instance.userChanges().listen((event) {
      if (user == event) return;
      safeSetState(() => user = event);
    });
    super.initState();
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(fn);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return LoginScreen();
    return LoadingScreen<AppUser?>(
      future: AppUserNetworks.user,
      func: (user) => user == null ? SignUpScreen() : HomeScreen(user),
      errFunc: (e) {
        if (e is PlatformException) {
          if (e.code == 'not-signed-in') return LoginScreen();
        }
        return SignUpScreen();
      },
    );
  }
}
