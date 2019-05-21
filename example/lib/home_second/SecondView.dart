import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:flutter/material.dart';

class SecondView extends BlocStatelessView<SecondBloc,SecondStreams> {


  @override
  void eventReceiver(EventsBase event) {
    // TODO: implement eventReceiver
  }

  @override
  Widget buildView(BuildContext context, SecondStreams streams) {

    return Material(
      child: Center(
        child: StreamBuilder(
            stream: streams.msg.get,
            initialData: "",
            builder: (_,snapshot){
              var msg = snapshot.hasData ? snapshot.data : "not msg";
              return Text(msg);
            }
        ),
      ),
    );

  }
  
}
