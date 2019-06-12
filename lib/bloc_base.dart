import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/widgets.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {
  T streams;
  String uuid;
  BuildContext context;

  BlocBase() {
    uuid = "${DateTime.now().millisecondsSinceEpoch.toString()}-bloc";
  }

  void dispatchView(E event) {
    Dispatcher().dispatchToView(this, event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    Dispatcher().dispatchToBlocs<T>(event);
  }

  void initView();

  void eventReceiver(E event);

  void dispose() {
    Dispatcher().unRegisterBloc(this);
    streams.dispose();
  }
}
