import 'package:bsev/bloc_base.dart';
import 'package:bsev/bsev_widget.dart';
import 'package:bsev/communication_base.dart';
import 'package:bsev/injector.dart';

S buildBsevCommunication<B extends BlocBase, S extends CommunicationBase>({
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
