
import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home_second/SecondEvents.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';

class SecondBloc extends BlocBase<SecondStreams,EventsBase>{

  @override
  void eventReceiver(EventsBase event) {

    if(event is SecondEvents){
      streams.msg.set(event.data);
    }

  }

  @override
  void initView() {

  }

}