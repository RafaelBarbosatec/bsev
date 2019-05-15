import 'package:bsev/bloc_view.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/stream_create.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {

  final typeStreams = T;
  var _eventToBloc = PublishSubjectCreate<E>();
  var _eventToView = PublishSubjectCreate<E>();
  BuildContext _context;

  T streams;

  BlocBase() {
    _eventToBloc.get.listen(eventReceiver);
  }

  void registerView(BlocView view,BuildContext context) {
    _context = context;
    _eventToView.get.listen(view.eventReceiver);
  }

  void dispatchView(E event) {
    _eventToView.set(event);
  }

  void dispatch(E event) {
    _eventToBloc.set(event);
  }

  T getBloc<T>(){
    return Provider.of<T>(_context);
  }

  void initView();

  void eventReceiver(E event);

  void dispose() {
    streams.dispose();
    _eventToBloc.close();
    _eventToView.close();
  }
}