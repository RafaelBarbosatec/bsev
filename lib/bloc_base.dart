import 'package:bsev/bloc_view.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/stream_create.dart';

abstract class BlocBase<T extends StreamsBase, E extends EventsBase> {

  var _eventToBloc = PublishSubjectCreate<E>();
  var _eventToView = PublishSubjectCreate<E>();

  T streams;

  BlocBase() {
    _eventToBloc.get.listen(eventReceiver);
  }

  void registerView(BlocView view) {
    _eventToView.get.listen(view.eventReceiver);
  }

  void dispatchView(E event) {
    _eventToView.set(event);
  }

  void dispatch(E event) {
    _eventToBloc.set(event);
  }

  void initView();
  void initState();

  void eventReceiver(E event);

  void dispose() {
    streams.dispose();
    _eventToBloc.close();
    _eventToView.close();
  }
}