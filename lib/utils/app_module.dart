import 'package:dapp/screens/screens.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => AuthState()),
      ];
}
