import 'package:bsev/bsev.dart';
import 'package:bsev_demo/screens/second/bloc/bloc.dart';

class SecondBloc extends BlocBase<SecondStreams> {
  @override
  void eventReceiver(EventsBase event) {
    if (event is SecondEventIncrement) {
      communication.count.set((communication.count.value ?? 0) + 1);
    }
  }

  @override
  void initView() {}
}
