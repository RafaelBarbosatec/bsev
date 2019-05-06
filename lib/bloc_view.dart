import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_provider.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:simple_injector/simple_injector.dart';

abstract class BlocView<E extends EventsBase> {
  void eventReceiver(E event);
}

// ignore: must_be_immutable
abstract class BlocStatelessView<B extends BlocBase, S extends StreamsBase,
    E extends EventsBase> extends StatelessWidget implements BlocView<E> {
  B _bloc;

  S get streams {
    return _bloc.streams;
  }

  @protected
  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _initBlocView(context);
    return buildView(context);
  }

  void _initBlocView(BuildContext context) {
    try {
      _bloc = getBloc<B>(context);
      _bloc.registerView(this);
    } catch (e) {
      debugPrint("Error: Não encontrado BloC para ser registrado.\n"
          "Crie widget usando:\n"
          "$this().create()");
    }
  }

  void dispatch(E event) {
    _bloc.dispatch(event);
  }

  Widget create({forceUpdateBloc = false}) {
    return BlocProvider<B>(
      child: this,
      bloc: SimpleInjector().inject(),
      forceUpdateBloc: forceUpdateBloc,
    );
  }

  T getBloc<T extends BlocBase>(BuildContext context){
    return BlocProvider.of<T>(context);
  }
}

/**
 * nesessario criar method:
 *
 * static Widget create(){
      return BlocProvider<HomeBloc>(
        child: HomeView(),
        bloc: SimpleInjector().inject(),
      );
    }

    no StatefulWidget
 */

mixin BlocViewMixin<B extends BlocBase, S extends StreamsBase,
    E extends EventsBase> implements BlocView<E> {
  B _bloc;

  S get streams {
    return _bloc.streams;
  }

  @protected
  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _initBlocView(context);
    return buildView(context);
  }

  void _initBlocView(BuildContext context) {
    try {
      if (_bloc == null) {
        _bloc = getBloc<B>(context);
        _bloc.registerView(this);
      }
    } catch (e) {
      debugPrint("Error: Não encontrado BloC para ser registrado.\n"
          "Crie widget usando:\n"
          "return BlocProvider<$B>(\n"
          "  child: Widget(),\n"
          "  bloc: SimpleInjector().inject(),\n"
          ");");
    }
  }

  void dispatch(E event) {
    _bloc.dispatch(event);
  }

  T getBloc<T extends BlocBase>(BuildContext context){
    return BlocProvider.of<T>(context);
  }
}
