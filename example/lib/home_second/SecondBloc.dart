import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home_second/SecondEvents.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';

class SecondBloc extends BlocBase<SecondStreams> {
  int count = 0;

  @override
  void eventReceiver(EventsBase event) {
    if (event is SecondEventIncrement) {
      count++;
      streams.count.set(count);
    }
  }

  @override
  void initView() {}
}
