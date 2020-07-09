import 'package:bsev/src/bloc.dart';
import 'package:bsev/src/bsev_builder.dart';
import 'package:bsev/src/communication.dart';
import 'package:bsev/src/injector.dart';

class Bsev {
  static S buildCommunication<B extends Bloc, S extends Communication>({
    dynamic dataToBloc,
    ReceiveEventCallBack eventReceiver,
  }) {
    final _communication = getDependency<S>();

    if (!_communication.blocInitialized) {
      _communication.setBloc(
        getDependency<B>()..data = dataToBloc,
      );
    }
    if (eventReceiver != null) {
      _communication.addEventReceiver(eventReceiver);
    }
    return _communication;
  }
}
