import 'package:bsev/bsev.dart';

class BlocCommunication<S> {
  final void Function(EventsBase) dispatcher;
  final S streams;

  BlocCommunication(this.dispatcher, this.streams);
}
