import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_create.dart';

abstract class Dispatcher {
  void registerBSEV(BlocBase bloc, BlocView view);
  void unRegisterBloc(BlocBase bloc);
  void dispatch(BlocView view, EventsBase event);
  void dispatchToBlocs<T extends BlocBase>(EventsBase event);
  void dispatchToView(BlocBase bloc, EventsBase event);
}

class DispatcherStream implements Dispatcher {
  static const LOG = "(Dispatcher)";
  static final DispatcherStream _singleton = DispatcherStream._internal();

  Map _blocCollection = Map<String, PublishSubjectCreate>();
  Map<Type, List<String>> _blocsToUuids = Map<Type, List<String>>();
  Map<String, String> _viewToBloc = Map<String, String>();
  Map _viewCollection = Map<String, PublishSubjectCreate>();

  factory DispatcherStream() {
    return _singleton;
  }

  DispatcherStream._internal();

  void registerBSEV(BlocBase bloc, BlocView view) {
    bloc.setDispatcher(this);
    //RegisterBloc
    if (_blocCollection[bloc.uuid] == null) {
      _addUuidListBloc(bloc);
      _blocCollection[bloc.uuid] = PublishSubjectCreate<EventsBase>();
      _blocCollection[bloc.uuid].get.listen(bloc.eventReceiver);
    }

    //registerView
    try {
      if (_viewCollection[bloc.uuid] == null) {
        _viewCollection[bloc.uuid] = PublishSubjectCreate<EventsBase>();
        _viewCollection[bloc.uuid].get.listen(view.eventReceiver);
      }
      _addViewToBloc(bloc, view);
    } catch (e) {
      print("$LOG ERROR: $e");
    }
  }

  void unRegisterBloc(BlocBase bloc) {
    if (_blocCollection[bloc.uuid] != null) {
      _removeUuidListBloc(bloc);
      _removeViewToBloc(bloc);
      _blocCollection[bloc.uuid].close();
      _blocCollection.remove(bloc.uuid);
    }

    if (_viewCollection[bloc.uuid] != null) {
      _viewCollection[bloc.uuid].close();
      _viewCollection.remove(bloc.uuid);
    }
  }

  void dispatch(BlocView view, EventsBase event) {
    var uuidBloc = _viewToBloc[view.uuid];

    if (uuidBloc != null) {
      _blocCollection[uuidBloc].set(event);
    } else {
      print("$LOG ERROR: Bloc to $view not found.");
    }
  }

  void dispatchAll(EventsBase event) {
    _blocCollection.forEach((id, stream) {
      stream.set(event);
    });
  }

  void dispatchToBlocs<T extends BlocBase>(EventsBase event) {
    var uuids = _blocsToUuids[T];
    if (uuids != null && uuids.length > 0) {
      uuids.forEach((uuid) {
        _blocCollection[uuid].set(event);
      });
    } else {
      print("$LOG ERROR: $T not found.");
    }
  }

  void dispatchToView(BlocBase bloc, EventsBase event) {
    var publish = _viewCollection[bloc.uuid];

    if (publish != null) {
      publish.set(event);
    } else {
      print(
          "$LOG ERROR: View of the ${bloc.runtimeType}/${bloc.uuid} not found.");
    }
  }

  void _addUuidListBloc(BlocBase bloc) {
    if (_blocsToUuids[bloc.runtimeType] == null) {
      _blocsToUuids[bloc.runtimeType] = List();
      _blocsToUuids[bloc.runtimeType].add(bloc.uuid);
    } else {
      _blocsToUuids[bloc.runtimeType].add(bloc.uuid);
    }
  }

  void _removeUuidListBloc(BlocBase bloc) {
    _blocsToUuids[bloc.runtimeType].remove(bloc.uuid);
  }

  void _addViewToBloc(BlocBase bloc, BlocView view) {
    if (_viewToBloc.containsValue(bloc.uuid)) {
      _viewToBloc.removeWhere((key, value) => value == bloc.uuid);
    }
    _viewToBloc[view.uuid] = bloc.uuid;
  }

  void _removeViewToBloc(BlocBase bloc) {
    _viewToBloc.removeWhere((key, value) => value == bloc.uuid);
  }
}
