import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_provider.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BlocView<E extends EventsBase> {
  void eventReceiver(E event);
}

// ignore: must_be_immutable
abstract class BlocStatelessView<B extends BlocBase, S extends StreamsBase>
    extends StatelessWidget implements BlocView<EventsBase> {

  @protected
  Widget buildView(BuildContext context, S streams);

  @override
  Widget build(BuildContext context) {
    var streams = _initBlocView(context);
    return buildView(context,streams);
  }

  S _initBlocView(BuildContext context) {
    try {
      var _bloc = getBloc<B>(context);
      Dispatcher().registerView(_bloc, this);
      return _bloc.streams;
    } catch (e) {
      debugPrint("Error: Não encontrado BloC para ser registrado.\n"
          "Crie widget usando:\n"
          "$this().create()");
      return null;
    }
  }

  void dispatch(EventsBase event) {
    Dispatcher().dispatch<B>(event);
  }

  Widget create({forceUpdateBloc = false}) {
    return BlocProvider<B, S>(
      child: this,
    );
  }

  T getBloc<T extends BlocBase>(BuildContext context) {
    return Provider.of<T>(context);
  }
}

/**
 * nesessario criar method:
 *
 * static Widget create(){
      return BlocProvider<BlocBase,StreamsBase>(
        child: Widget(),
      );
    }

    no StatefulWidget
 */

mixin BlocViewMixin<B extends BlocBase, S extends StreamsBase>
    implements BlocView<EventsBase> {
  B _bloc;

  S get streams {
    return _bloc.streams;
  }

  @protected
  Widget buildView(BuildContext context, S streams);

  @override
  Widget build(BuildContext context) {
    var streams = _initBlocView(context);
    return buildView(context,streams);
  }

  S _initBlocView(BuildContext context) {
    try {
      var _bloc = getBloc<B>(context);
      Dispatcher().registerView(_bloc, this);
      return _bloc.streams;
    } catch (e) {
      debugPrint("Error: Não encontrado BloC para ser registrado.\n"
          "Crie widget usando:\n"
          "return BlocProvider<$B,$S>(\n"
          "  child: Widget(),\n"
          ");");
      return null;
    }
  }

  void dispatch(EventsBase event) {
    Dispatcher().dispatch<B>(event);
  }

  T getBloc<T extends BlocBase>(BuildContext context) {
    return Provider.of<T>(context);
  }
}
