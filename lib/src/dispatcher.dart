import 'package:bsev/src/bloc.dart';
import 'package:bsev/src/communication.dart';
import 'package:bsev/src/events_base.dart';

abstract class Dispatcher {
  void registerBloc(Bloc bloc);
  void unRegisterBloc(Bloc bloc);
  void dispatchToBlocs<T extends Bloc>(EventsBase event);
}

class GlobalBlocDispatcher implements Dispatcher {
  static final GlobalBlocDispatcher _singleton =
      GlobalBlocDispatcher._internal();

  List<Bloc> _blocs = List();

  factory GlobalBlocDispatcher() {
    return _singleton;
  }

  GlobalBlocDispatcher._internal();

  @override
  void dispatchToBlocs<T extends Bloc<Communication>>(EventsBase event) {
    _blocs.where((blocs) => blocs is T).forEach((bloc) {
      bloc.eventReceiver(event);
    });
  }

  @override
  void registerBloc(Bloc<Communication> bloc) {
    _blocs.add(bloc);
  }

  @override
  void unRegisterBloc(Bloc<Communication> bloc) {
    _blocs.remove(bloc);
  }
}
