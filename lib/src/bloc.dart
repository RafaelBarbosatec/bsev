import 'package:bsev/src/communication.dart';
import 'package:bsev/src/events_base.dart';

abstract class Bloc<T extends Communication> {
  T communication;
  dynamic data;

  void init() {}

  void eventReceiver(EventsBase event);

  void dispatchView(EventsBase event) {
    return communication?.dispatchView(event);
  }

  void dispatchToBloc<T extends Bloc>(EventsBase event) {
    communication?.dispatchToBloc<T>(event);
  }

  void dispatchToAllBlocs(EventsBase event) {
    return communication?.dispatchToAllBlocs(event);
  }
}
