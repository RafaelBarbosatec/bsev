import 'package:bsev/bsev.dart';
import 'package:bsev_demo/screens/second/bloc/second_bloc.dart';
import 'package:bsev_demo/screens/second/bloc/second_communication.dart';
import 'package:bsev_demo/screens/second/bloc/second_events.dart';
import 'package:flutter/material.dart';

class SecondViewStateful extends StatefulWidget {
  @override
  _SecondViewStatefulState createState() => _SecondViewStatefulState();
}

class _SecondViewStatefulState extends State<SecondViewStateful> {
  SecondCommunication communication;

  @override
  void initState() {
    communication = buildCommunication<SecondBloc, SecondCommunication>();
    communication.init();
    super.initState();
  }

  @override
  void dispose() {
    // if you registered the bloc as a singleton, remember not to do Dispose.
    communication.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example without Bsev"),
      ),
      body: Center(
        child: communication.count.builder<int>((msg) {
          return Text(msg.toString());
        }, buildEmpty: (context) {
          // example add empty widget
          return Center(
            child: Text("Empty"),
          );
        }, transitionBuilder: (child, animate) {
          // example custom transaction empty to content
          return ScaleTransition(
            scale: animate,
            child: child,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          communication.dispatcher(SecondEventIncrement());
        },
      ),
    );
  }
}
