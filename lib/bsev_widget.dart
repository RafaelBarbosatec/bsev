import 'package:bsev/bloc_base.dart';
import 'package:bsev/communication_base.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';

typedef AsyncWidgetBuilder<S> = Widget Function(
    BuildContext context, S communication);

typedef ReceiveEventCallBack = Function(
    EventsBase event, CommunicationBase communication);

// ignore: must_be_immutable
class Bsev<B extends BlocBase, S extends CommunicationBase>
    extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final ReceiveEventCallBack eventReceiver;

  AsyncWidgetBuilder<CommunicationBase> _builderInner;
  ReceiveEventCallBack _eventReceiverInner;

  Bsev({Key key, @required this.builder, this.eventReceiver, this.dataToBloc})
      : super(key: key) {
    _confBuilders();
  }

  @override
  _BsevState<B, S> createState() => _BsevState<B, S>();

  void _confBuilders() {
    _builderInner = (context, communication) => builder(context, communication);
    _eventReceiverInner = (event, communication) {
      if (eventReceiver != null) eventReceiver(event, communication);
    };
  }
}

class _BsevState<B extends BlocBase, S extends CommunicationBase>
    extends State<Bsev> {
  S _communication;

  @override
  void initState() {
    _communication = buildBsevCommunication<B, S>(
      dataToBloc: widget.dataToBloc,
      eventReceiver: widget._eventReceiverInner,
    );
    super.initState();
  }

  @override
  void dispose() {
    _communication.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _communication.initView();
    return widget._builderInner(context, _communication);
  }
}
