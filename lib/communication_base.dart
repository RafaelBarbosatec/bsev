import 'package:bsev/bloc_base.dart';
import 'package:bsev/bsev_widget.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';

typedef EventReceiver = void Function(EventsBase event);

abstract class CommunicationBase {
  BlocBase _bloc;
  final List<ReceiveEventCallBack> _eventReceivers = List();
  final Dispatcher _dispatcherBlocs = GlobalBlocDispatcher();
  bool _calledInitView = false;
  bool isSingleton = false;

  void addEventReceiver(ReceiveEventCallBack eventReceiver) {
    _eventReceivers.add(eventReceiver);
  }

  void removeEventReceiver(ReceiveEventCallBack eventReceiver) {
    _eventReceivers.remove(eventReceiver);
  }

  void setBloc(BlocBase bloc) {
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

  void dispatchToBloc<T extends BlocBase>(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<T>(event);
  }

  void dispatchToAllBlocs(EventsBase event) {
    _dispatcherBlocs?.dispatchToBlocs<BlocBase>(event);
  }

  void initView() {
    if (!_calledInitView) {
      _calledInitView = true;
      _bloc.initView();
    }
  }

  void dispose() {
    _eventReceivers.clear();
    _dispatcherBlocs?.unRegisterBloc(_bloc);
  }

  bool get blocInitialized => _bloc != null;
}
