import 'package:bsev/flavors.dart';
import 'package:bsev_demo/di/InjectBloc.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'home/HomeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    WidgetsFlutterBinding.ensureInitialized();
    Flavors.configure(Flavor.PROD);
    initDependencies(Injector.appInstance);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
