import 'package:flutter_modular/flutter_modular.dart';
import 'package:online_classroom/screens/screens.dart';
import 'package:online_classroom/utils/utils.dart';

class AppModule extends Module {
  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute(Routes.authState, child: (_, __) => AuthState()),
        ChildRoute(Routes.homeScreen, child: (_, __) => HomeScreen(__.data)),
        ChildRoute(Routes.joinClass,
            child: (_, __) => JoinClassScreen(__.data)),
        ChildRoute(Routes.createClass,
            child: (_, __) => CreateClassScreen(__.data)),
        ChildRoute(Routes.classScreen, child: (_, __) => ClassScreen(__.data)),
      ];
}
