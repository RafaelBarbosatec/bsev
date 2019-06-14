library bsev;

export 'package:bsev/bloc_base.dart';
export 'package:bsev/bloc_view.dart';
export 'package:bsev/events_base.dart';
export 'package:bsev/stream_base.dart';
export 'package:bsev/stream_create.dart';
export 'package:injector/injector.dart';

import 'package:bsev/dispatcher.dart';
import 'package:bsev/stream_base.dart';
import 'package:bsev/util.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import 'bsev.dart';

typedef AsyncWidgetBuilder<S> = Widget Function(
    BuildContext context, Function(EventsBase) dispatcher, S streams);

class Bsev<B extends BlocBase, S extends StreamsBase> extends StatefulWidget {
  final dynamic dataToBloc;
  final AsyncWidgetBuilder<S> builder;
  final Function(EventsBase, Function(EventsBase) dispatcher) eventReceiver;

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
  B _bloc;

  @override
  String uuid = "${generateId()}-view";

  Function(EventsBase event) dispatcher;

  @override
  void eventReceiver(EventsBase event) {
    if (widget.eventReceiver != null) {
      widget.eventReceiver(event, dispatcher);
    }
  }

  @override
  void initState() {
    _bloc = Injector.appInstance.getDependency<B>();
    _bloc.data = widget.dataToBloc;
    _bloc.streams = Injector.appInstance.getDependency<S>();
    _bloc.dispatcher = DispatcherStream();
    DispatcherStream().registerBSEV(_bloc, this);
    dispatcher = (event) {
      DispatcherStream().dispatch(this, event);
    };
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.context = context;
    return Provider<B>.value(
        value: _bloc,
        child: widget.builderInner(context, dispatcher, _bloc.streams));
  }

  void _afterLayout(_) {
    _bloc.initView();
  }

  @override
  void dispose() {
    DispatcherStream().unRegisterBloc(_bloc);
    _bloc.dispose();
    super.dispose();
  }
}
