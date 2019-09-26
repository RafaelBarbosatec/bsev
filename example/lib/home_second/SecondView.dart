import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondEvents.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:flutter/material.dart';

class SecondView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Bsev<SecondBloc,SecondStreams>(
      builder: (_,dispatcher, SecondStreams streams){

        return Scaffold(
          appBar: AppBar(
            title: Text("Second example"),
          ),
          body: Center(
            child: StreamBuilder(
                stream: streams.count.get,
                builder: (_,snapshot){
                  var msg = snapshot.hasData ? snapshot.data.toString() : "0";
                  return Text(msg);
                }
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                dispatcher(SecondEventIncrement());
              }
          ),
        );

      },
    );

  }

}

