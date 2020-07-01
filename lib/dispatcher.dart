import 'package:bsev/bloc_base.dart';
import 'package:bsev/communication_base.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_create.dart';

abstract class Dispatcher {
  void registerBloc(BlocBase bloc);
  void unRegisterBloc(BlocBase bloc);
  void dispatchToBlocs<T extends BlocBase>(EventsBase event);
}

class CommunicationBlocView {
  final String uuidBloc;
  final String uuidView;
  final PublishSubjectCreate stream;

  CommunicationBlocView(this.uuidBloc, this.uuidView, this.stream);
}

class GlobalBlocDispatcher implements Dispatcher {
  static final GlobalBlocDispatcher _singleton =
      GlobalBlocDispatcher._internal();

  List<BlocBase> _blocs = List();

  factory GlobalBlocDispatcher() {
    return _singleton;
  }

  GlobalBlocDispatcher._internal();

  @override
  void dispatchToBlocs<T extends BlocBase<CommunicationBase>>(
      EventsBase event) {
    _blocs.where((blocs) => blocs is T).forEach((bloc) {
      bloc.eventReceiver(event);
    });
  }

  @override
  void registerBloc(BlocBase<CommunicationBase> bloc) {
    _blocs.add(bloc);
  }

  @override
  void unRegisterBloc(BlocBase<CommunicationBase> bloc) {
    _blocs.remove(bloc);
  }
}
