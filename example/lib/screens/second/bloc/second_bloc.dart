import 'package:bsev/bsev.dart';
import 'package:bsev_demo/screens/second/bloc/bloc.dart';

class SecondBloc extends Bloc<SecondCommunication> {
  @override
  void eventReceiver(EventsBase event) {
    if (event is SecondEventIncrement) {
      communication.count.set((communication.count.value ?? 0) + 1);
    }
  }
}
