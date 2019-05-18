import 'package:bsev/bloc_base.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class BlocProvider<T extends BlocBase, S extends StreamsBase>
    extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _BlocProviderState<T, S> createState() => _BlocProviderState<T, S>();
}

class _BlocProviderState<B extends BlocBase, S extends StreamsBase>
    extends State<BlocProvider<B, S>> {
  B bloc;

  @override
  void initState() {
    bloc = Injector.appInstance.getDependency<B>();
    bloc.streams = Injector.appInstance.getDependency<S>();
    Dispatcher().registerBloc(bloc, bloc.eventReceiver);
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<B>.value(value: bloc, child: widget.child);
  }

  void _afterLayout(_) {
    bloc.initView();
  }
}
