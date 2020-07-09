import 'package:bsev/src/bloc.dart';
import 'package:bsev/src/bsev_builder.dart';
import 'package:bsev/src/dispatcher.dart';
import 'package:bsev/src/events_base.dart';

typedef EventReceiver = void Function(EventsBase event);

abstract class Communication {
  Bloc _bloc;
  final List<ReceiveEventCallBack> _eventReceivers = List();
  final Dispatcher _dispatcherBlocs = GlobalBlocDispatcher();
  bool isSingleton = false;

  void addEventReceiver(ReceiveEventCallBack eventReceiver) {
    _eventReceivers.add(eventReceiver);
  }

  void removeEventReceiver(ReceiveEventCallBack eventReceiver) {
    _eventReceivers.remove(eventReceiver);
  }

  void setBloc(Bloc bloc) {
    _bloc = bloc;
    _bloc.communication = this;
    _dispatcherBlocs?.registerBloc(_bloc);
  }

  void dispatchView(EventsBase event) {
    _eventReceivers.forEach((element) => element(event, this));
  }

  void dispatcher(EventsBase event) {
    _bloc?.eventReceiver(event);
  }

  void dispatchToBloc<T extends Bloc>(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<T>(event);
  }

  void dispatchToAllBlocs(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<Bloc>(event);
  }

  void init() {
    _bloc.init();
  }

  void dispose() {
    _eventReceivers.clear();
    _dispatcherBlocs?.unRegisterBloc(_bloc);
  }

  bool get blocInitialized => _bloc != null;
}
