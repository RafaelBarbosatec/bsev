import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/widgets.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {
  final typeStreams = T;

  T streams;
  BuildContext context;

  void dispatchView(E event) {
    Dispatcher().dispatchToView(this, event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    Dispatcher().dispatch<T>(event);
  }

  void initView();

  void eventReceiver(E event);

  void dispose() {
    Dispatcher().unRegisterBloc(this);
    streams.dispose();
  }
}
