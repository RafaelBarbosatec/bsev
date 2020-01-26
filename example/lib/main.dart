import 'package:bsev/flavors.dart';
import 'package:bsev_demo/di/initDependencies.dart';
import 'package:flutter/material.dart';

import 'home/HomeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    WidgetsFlutterBinding.ensureInitialized();
    Flavors.configure(Flavor.PROD);
    initDependencies();
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
