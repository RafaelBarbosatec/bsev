import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondEvents.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:flutter/material.dart';

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bsev<SecondBloc, SecondStreams>(
      builder: (_, communication) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Second example"),
          ),
          body: Center(
            child: communication.streams.count.builder<int>((msg) {
              return Text(msg.toString());
            }, buildEmpty: (context) {
              return Center(
                child: Text("Empty"),
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                communication.dispatcher(SecondEventIncrement());
              }),
        );
      },
    );
  }
}
