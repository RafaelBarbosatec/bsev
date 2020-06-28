import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';

import 'bloc_view.dart';

abstract class BlocBase<T extends StreamsBase> {
  T streams;
  dynamic data;
  Dispatcher _dispatcher;
  BlocView _view;
  final String uuid = "${generateId()}-bloc";

  void dispatchView(EventsBase event) {
    _view?.eventReceiver(event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    _dispatcher?.dispatchToBlocs<T>(event);
  }

  void setDispatcher(Dispatcher dispatcher) {
    _dispatcher = dispatcher;
    _dispatcher?.registerBloc(this);
  }

  void setView(BlocView view) {
    _view = view;
  }

  void initView();

  void eventReceiver(EventsBase event);

  void dispose() {
    _dispatcher?.unRegisterBloc(this);
    streams.dispose();
  }
}
