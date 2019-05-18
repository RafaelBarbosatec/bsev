import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_create.dart';

class Dispatcher {
  static var LOG = "(Dispatcher)";
  static final Dispatcher _singleton = Dispatcher._internal();

  Map _blocCollection = Map<Type, PublishSubjectCreate>();
  Map _viewCollection = Map<Type, PublishSubjectCreate>();

  factory Dispatcher() {
    return _singleton;
  }

  Dispatcher._internal();

  void registerBloc(BlocBase bloc, Function(EventsBase) reciver) {
    if (_blocCollection[bloc.runtimeType] == null) {
      _blocCollection[bloc.runtimeType] = PublishSubjectCreate<EventsBase>();
      _blocCollection[bloc.runtimeType].get.listen(reciver);
    }
  }

  void registerView(BlocBase bloc, BlocView view) {
    if (_viewCollection[bloc.runtimeType] == null) {
      _viewCollection[bloc.runtimeType] = PublishSubjectCreate<EventsBase>();
      _viewCollection[bloc.runtimeType].get.listen(view.eventReceiver);
    }
  }

  void unRegisterBloc(BlocBase bloc) {
    if (_blocCollection[bloc.runtimeType] != null) {
      _blocCollection[bloc.runtimeType].close();
      _blocCollection.remove(bloc.runtimeType);
    }

    if (_viewCollection[bloc.runtimeType] != null) {
      _viewCollection[bloc.runtimeType].close();
      _viewCollection.remove(bloc.runtimeType);
    }
  }

  void dispatch<T extends BlocBase>(EventsBase event) {
    var publish = _blocCollection[T];

    if (publish != null) {
      _blocCollection[T].set(event);
    } else {
      print("$LOG ERROR: $T not found.");
    }
  }

  void dispatchToView(BlocBase bloc, EventsBase event) {
    var publish = _viewCollection[bloc.runtimeType];

    if (publish != null) {
      _viewCollection[bloc.runtimeType].set(event);
    } else {
      print("$LOG ERROR: View of the ${bloc.runtimeType} not found.");
    }
  }
}
