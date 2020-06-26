import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_create.dart';

abstract class Dispatcher {
  void registerBSEV(BlocBase bloc, BlocView view);
  void unRegisterBloc(BlocBase bloc, BlocView view);
  void dispatch(BlocView view, EventsBase event);
  void dispatchToBlocs<T extends BlocBase>(EventsBase event);
  void dispatchToView(BlocBase bloc, EventsBase event);
}

class CommunicationBlocView {
  final String uuidBloc;
  final String uuidView;
  final PublishSubjectCreate stream;

  CommunicationBlocView(this.uuidBloc, this.uuidView, this.stream);
}

class DispatcherStream implements Dispatcher {
  static const LOG = "(Dispatcher)";
  static final DispatcherStream _singleton = DispatcherStream._internal();

  Map _blocCollection = Map<String, PublishSubjectCreate>();
  Map<Type, List<String>> _blocsToUuids = Map<Type, List<String>>();
  List<CommunicationBlocView> _viewCollection = List();

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
      if (_viewCollection.firstWhere((element) => element.uuidView == view.uuid,
              orElse: () => null) ==
          null) {
        final communication = CommunicationBlocView(
          bloc.uuid,
          view.uuid,
          PublishSubjectCreate<EventsBase>(),
        );
        communication.stream.get.listen(view.eventReceiver);
        _viewCollection.add(communication);
      }
//      _addViewToBloc(bloc, view);
    } catch (e) {
      print("$LOG ERROR: $e");
    }
  }

  void unRegisterBloc(BlocBase bloc, BlocView view) {
    if (_blocCollection[bloc.uuid] != null && !bloc.isSingleton) {
      _removeUuidListBloc(bloc);
      _blocCollection[bloc.uuid].close();
      _blocCollection.remove(bloc.uuid);
      bloc.dispose();
    }

    var communication = _viewCollection.firstWhere(
        (element) => element.uuidView == view.uuid,
        orElse: () => null);

    if (communication != null) {
      communication.stream.close();
      _viewCollection.remove(communication);
    }
  }

  void dispatch(BlocView view, EventsBase event) {
    var communication = _viewCollection.firstWhere(
        (element) => element.uuidView == view.uuid,
        orElse: () => null);
    if (communication != null) {
      _blocCollection[communication.uuidBloc].set(event);
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
    _viewCollection
        .where(
      (element) => element.uuidBloc == bloc.uuid,
    )
        .forEach((element) {
      element.stream.set(event);
    });
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
}
