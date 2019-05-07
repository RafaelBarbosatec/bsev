import 'package:bsev/bloc_base.dart';
import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
    this.forceUpdateBloc = false,
  }) : super(key: key);

  final Widget child;
  final T bloc;
  final bool forceUpdateBloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {

  T bloc;

  @override
  void initState() {
    _initStateBloc();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BlocProvider<T> oldWidget) {
    if(oldWidget.bloc != widget.bloc && widget.forceUpdateBloc){
      _initStateBloc();
      _afterLayout(0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return new _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );

  }

  void _initStateBloc() {
    bloc?.dispose();
    bloc = widget.bloc;
    bloc.initState();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100),bloc.initView);
  }

}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
