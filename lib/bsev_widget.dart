import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/communication_base.dart';
import 'package:bsev/events_base.dart';
import 'package:flutter/widgets.dart';

import 'injector.dart';

typedef AsyncWidgetBuilder<S> = Widget Function(
    BuildContext context, S communication);

typedef ReceiveEventCallBack<S> = Function(EventsBase event, S communication);

// ignore: must_be_immutable
class Bsev<B extends BlocBase, S extends CommunicationBase>
    extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final ReceiveEventCallBack<S> eventReceiver;

  AsyncWidgetBuilder<CommunicationBase> _builderInner;
  ReceiveEventCallBack<CommunicationBase> _eventReceiverInner;

  Bsev({Key key, @required this.builder, this.eventReceiver, this.dataToBloc})
      : super(key: key) {
    _confBuilders();
  }

  @override
  _BsevState<B, S> createState() => _BsevState<B, S>();

  void _confBuilders() {
    _builderInner = (context, communication) => builder(context, communication);
    if (eventReceiver != null) {
      _eventReceiverInner = (event, communication) {
        return eventReceiver(event, communication);
      };
    }
  }
}

class _BsevState<B extends BlocBase, S extends CommunicationBase>
    extends State<Bsev> implements BlocView<EventsBase> {
  B _bloc;

  @override
  void eventReceiver(EventsBase event) {
    if (widget._eventReceiverInner != null && mounted) {
      widget._eventReceiverInner(event, _bloc.communication);
    }
  }

  @override
  void initState() {
    _bloc = getDependency<B>();
    _bloc.data = widget.dataToBloc;
    _bloc.setCommunication(getDependency<S>());
    _bloc.communication.setView(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _bloc.initView());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, _bloc.communication);
  }
}
