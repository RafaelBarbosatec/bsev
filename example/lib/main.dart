import 'di/RepositoryModule.dart';
import 'di/BlocModule.dart';
import 'package:simple_injector/simple_injector.dart';
import 'home/HomeView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp(){
    SimpleInjector.configure(Flavor.PROD);
    SimpleInjector().registerModule(RepositoryModule());
    SimpleInjector().registerModule(BlocModule());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView().create(),
    );
  }
}