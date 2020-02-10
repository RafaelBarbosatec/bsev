import 'package:bsev/bsev.dart';

class BlocCommunication<S> {
  final Function(EventsBase) dispatcher;
  final S streams;

  BlocCommunication(this.dispatcher, this.streams);
}
