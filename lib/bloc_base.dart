import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';

abstract class BlocBase<T extends StreamsBase> {
  T streams;
  dynamic data;
  Dispatcher _dispatcher;
  final String uuid = "${generateId()}-bloc";

  void dispatchView(EventsBase event) {
    _dispatcher?.dispatchToView(this, event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    _dispatcher?.dispatchToBlocs<T>(event);
  }

  void setDispatcher(Dispatcher dispatcher) {
    _dispatcher = dispatcher;
  }

  void initView();

  void eventReceiver(EventsBase event);

  void dispose() {
    streams.dispose();
  }
}
