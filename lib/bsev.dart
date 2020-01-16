library bsev;

export 'package:bsev/bloc_base.dart';
export 'package:bsev/bloc_view.dart';
export 'package:bsev/events_base.dart';
export 'package:bsev/stream_base.dart';
export 'package:bsev/stream_create.dart';
export 'package:bsev/stream_listener.dart';
export 'package:injector/injector.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';

import 'bsev.dart';

typedef AsyncWidgetBuilder<S> = Widget Function(
    BuildContext context, Function(EventsBase) dispatcher, S streams);

class Bsev<B extends BlocBase, S extends StreamsBase> extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final Function(BuildContext context, EventsBase event,
      Function(EventsBase) dispatcher) eventReceiver;

  AsyncWidgetBuilder<StreamsBase> builderInner;

  Bsev({Key key, @required this.builder, this.eventReceiver, this.dataToBloc})
      : super(key: key) {
    builderInner = (BuildContext context, Function(EventsBase) dispatcher,
        StreamsBase streams) {
      return builder(context, dispatcher, streams);
    };
  }

  @override
  _BsevState<B, S> createState() => _BsevState<B, S>();
}

class _BsevState<B extends BlocBase, S extends StreamsBase> extends State<Bsev>
    implements BlocView<EventsBase> {
  @override
  String uuid = "${generateId()}-view";

  B _bloc;
  Function(EventsBase event) dispatcher;
  final Dispatcher _myDispatcher = DispatcherStream();

  @override
  void eventReceiver(EventsBase event) {
    if (widget.eventReceiver != null) {
      widget.eventReceiver(context, event, dispatcher);
    }
  }

  @override
  void initState() {
    _bloc = Injector.appInstance.getDependency<B>();
    _bloc.data = widget.dataToBloc;
    _bloc.streams = Injector.appInstance.getDependency<S>();
    _bloc.setDispatcher(_myDispatcher);
    _myDispatcher.registerBSEV(_bloc, this);
    dispatcher = (event) {
      _myDispatcher.dispatch(this, event);
    };
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builderInner(context, dispatcher, _bloc.streams);
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
