import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';

abstract class CommunicationBase {
  BlocBase _bloc;
  BlocView _view;
  final Dispatcher _dispatcherBlocs = GlobalBlocDispatcher();
  void setView(BlocView view) {
    _view = view;
  }

  void setBloc(BlocBase bloc) {
    _bloc = bloc;
    _dispatcherBlocs?.registerBloc(_bloc);
  }

  void dispatchView(EventsBase event) {
    _view?.eventReceiver(event);
  }

  void dispatcher(EventsBase event) {
    _bloc?.eventReceiver(event);
  }

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<T>(event);
  }

  void dispatchToAllBlocs(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<BlocBase>(event);
  }

  void dispose() {
    _dispatcherBlocs?.unRegisterBloc(_bloc);
  }
}
