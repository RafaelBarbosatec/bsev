import 'package:bsev/events_base.dart';

abstract class BlocView<E extends EventsBase> {
  String uuid;
  void eventReceiver(E event);
}
