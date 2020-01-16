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
            child: StreamListener<int>(
                stream: streams.count.get,
                contentEmpty: Center(child: Text("Empty",style: TextStyle(color: Colors.black),),),
                builder: (_,snapshot){
                  var msg = snapshot.data.toString();
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

