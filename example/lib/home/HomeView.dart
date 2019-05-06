import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeEvents.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:flutter/material.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams,HomeEvents> {

  @override
  Widget buildView(BuildContext context) {

    return Scaffold(
      body: Container(),
    );

  }

  @override
  void eventReceiver(HomeEvents event) {

  }
}
