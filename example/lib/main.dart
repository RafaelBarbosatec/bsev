
import 'package:bsev_demo/di/InjectBloc.dart';
import 'package:bsev_demo/di/InjectRepository.dart';
import 'package:bsev/flavors.dart';
import 'package:injector/injector.dart';

import 'home/HomeView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp(){

    Flavors.configure(Flavor.PROD);

    var injector = Injector.appInstance;
    injectBloc(injector);
    injectRepository(injector);

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