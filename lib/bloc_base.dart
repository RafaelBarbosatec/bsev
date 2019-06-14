import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {
  T streams;
  dynamic data;
  Dispatcher dispatcher;
  BuildContext context;
  final String uuid = "${generateId()}-bloc";

  void dispatchView(E event) {
    dispatcher?.dispatchToView(this, event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    dispatcher?.dispatchToBlocs<T>(event);
  }

  void initView();

  void eventReceiver(E event);

  void dispose() {
    streams.dispose();
  }
}
