import 'package:bsev/communication_base.dart';
import 'package:bsev/events_base.dart';

abstract class BlocBase<T extends CommunicationBase> {
  T communication;
  dynamic data;

  void initView();

  void eventReceiver(EventsBase event);

  void dispatchView(EventsBase event) {
    return communication?.dispatchView(event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    communication?.dispatchToBloc<T>(event);
  }

  void dispatchToAllBlocs(EventsBase event) {
    return communication?.dispatchToAllBlocs(event);
  }
}
