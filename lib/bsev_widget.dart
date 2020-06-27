import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_communication.dart';
import 'package:bsev/bloc_view.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';

import 'injector.dart';

typedef AsyncWidgetBuilder<S> = Widget Function(
    BuildContext context, BlocCommunication<S> communication);

typedef ReceiveEventCallBack<S> = Function(
    EventsBase event, BlocCommunication<S> communication);

// ignore: must_be_immutable
class Bsev<B extends BlocBase, S extends StreamsBase> extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final ReceiveEventCallBack<S> eventReceiver;

  AsyncWidgetBuilder<StreamsBase> _builderInner;
  ReceiveEventCallBack<StreamsBase> _eventReceiverInner;

  Bsev({Key key, @required this.builder, this.eventReceiver, this.dataToBloc})
      : super(key: key) {
    _confBuilders();
  }

  @override
  _BsevState<B, S> createState() => _BsevState<B, S>();

  void _confBuilders() {
    _builderInner = (context, communication) => builder(context, communication);
    if (eventReceiver != null) {
      _eventReceiverInner =
          (event, communication) => eventReceiver(event, communication);
    }
  }
}

class _BsevState<B extends BlocBase, S extends StreamsBase> extends State<Bsev>
    implements BlocView<EventsBase> {
  @override
  String uuid = "${generateId()}-view";

  B _bloc;
  BlocCommunication<S> _blocCommunication;

  @override
  void eventReceiver(EventsBase event) {
    if (widget._eventReceiverInner != null && mounted) {
      widget._eventReceiverInner(event, _blocCommunication);
    }
  }

  @override
  void initState() {
    _bloc = getDependency<B>();
    _bloc.data = widget.dataToBloc;
    _bloc.streams = getDependency<S>();
    _bloc.setView(this);
    _bloc.setDispatcher(GlobalBlocDispatcher());
    _blocCommunication = BlocCommunication<S>(
      _bloc.eventReceiver,
      _bloc.streams,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _bloc.initView);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, _blocCommunication);
  }
}
