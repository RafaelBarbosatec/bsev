import 'package:bsev/src/bloc.dart';
import 'package:bsev/src/bsev.dart';
import 'package:bsev/src/communication.dart';
import 'package:bsev/src/events_base.dart';
import 'package:flutter/widgets.dart';

typedef AsyncWidgetBuilder<S extends Communication> = Widget Function(
  BuildContext context,
  S communication,
);

typedef ReceiveEventCallBack<S extends Communication> = Function(
  EventsBase event,
  S communication,
);

// ignore: must_be_immutable
class BsevBuilder<B extends Bloc, S extends Communication>
    extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final ReceiveEventCallBack<S> eventReceiver;

  AsyncWidgetBuilder _builderInner;
  ReceiveEventCallBack _eventReceiverInner;

  BsevBuilder({
    Key key,
    @required this.builder,
    this.eventReceiver,
    this.dataToBloc,
  }) : super(key: key) {
    _confBuilders();
  }

  @override
  _BsevBuilderState<B, S> createState() => _BsevBuilderState<B, S>();

  void _confBuilders() {
    _builderInner = (context, communication) => builder(context, communication);
    _eventReceiverInner =
        (event, communication) => eventReceiver?.call(event, communication);
  }
}

class _BsevBuilderState<B extends Bloc, S extends Communication>
    extends State<BsevBuilder> {
  Communication communication;

  @override
  void initState() {
    communication = Bsev.buildCommunication<B, S>(
      dataToBloc: widget.dataToBloc,
      eventReceiver: widget._eventReceiverInner,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      communication.init();
    });
  }

  @override
  void dispose() {
    if (communication.isSingleton) {
      communication.removeEventReceiver(widget._eventReceiverInner);
    } else {
      communication.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, communication);
  }
}
