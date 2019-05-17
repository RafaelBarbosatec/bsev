import 'package:bsev/bloc_view.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/stream_create.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {
  final typeStreams = T;

  T streams;

  void dispatchView(E event) {
    Dispatcher().dispatchToView(this,event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    Dispatcher().dispatch<T>(event);
  }

  void initView();

  void eventReceiver(E event);

  void dispose() {
    streams.dispose();
    Dispatcher().unRegisterBloc(this);
  }
}
