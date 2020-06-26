import 'package:bsev/bsev.dart';
import 'package:bsev_demo/screens/second/bloc/bloc.dart';
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(msg.toString()),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondView()),
                      );
                    },
                  )
                ],
              );
            }, buildEmpty: (context) {
              return Center(
                child: Text("Empty"),
              );
            }, transitionBuilder: (child, animate) {
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
              }),
        );
      },
    );
  }
}
