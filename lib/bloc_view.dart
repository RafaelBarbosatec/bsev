import 'package:bsev/events_base.dart';

abstract class BlocView<E extends EventsBase> {
  void eventReceiver(E event);
}
