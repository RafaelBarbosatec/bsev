library bsev;

import 'package:bsev/bloc_communication.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';

import 'bsev.dart';

export 'package:bsev/bloc_base.dart';
export 'package:bsev/bloc_communication.dart';
export 'package:bsev/bloc_view.dart';
export 'package:bsev/events_base.dart';
export 'package:bsev/extensions.dart';
export 'package:bsev/injector.dart';
export 'package:bsev/stream_base.dart';
export 'package:bsev/stream_create.dart';
export 'package:bsev/stream_listener.dart';

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
  final Dispatcher _myDispatcher = DispatcherStream();

  @override
  void eventReceiver(EventsBase event) {
    if (widget._eventReceiverInner != null) {
      widget._eventReceiverInner(event, _blocCommunication);
    }
  }

  @override
  void initState() {
    _bloc = Injector.appInstance.getDependency<B>();
    _bloc.data = widget.dataToBloc;
    _bloc.streams = Injector.appInstance.getDependency<S>();
    _myDispatcher.registerBSEV(_bloc, this);
    _blocCommunication = BlocCommunication<S>(
        (event) => _myDispatcher.dispatch(this, event), _bloc.streams);
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, _blocCommunication);
  }

  void _afterLayout(_) {
    _bloc.initView();
  }

  @override
  void dispose() {
    _myDispatcher.unRegisterBloc(_bloc);
    _bloc.dispose();
    super.dispose();
  }
}
