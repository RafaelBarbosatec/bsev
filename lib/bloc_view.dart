import 'package:bsev/bloc_base.dart';
import 'package:bsev/bloc_provider.dart';
import 'package:bsev/dispatcher.dart';
import 'package:bsev/events_base.dart';
import 'package:bsev/stream_base.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BlocView<E extends EventsBase> {
  String uuid = "";
  void eventReceiver(E event);
}

abstract class BlocStatelessView<B extends BlocBase, S extends StreamsBase>
    extends StatelessWidget implements BlocView<EventsBase> {
  final String _uuidView =
      "${DateTime.now().millisecondsSinceEpoch.toString()}-view";

  @override
  set uuid(String _uuid) {}

  @override
  String get uuid => _uuidView;

  @protected
  Widget buildView(BuildContext context, S streams);

  @override
  Widget build(BuildContext context) {
    var streams = _initBlocView(context);
    return buildView(context, streams);
  }

  S _initBlocView(BuildContext context) {
    try {
      var _bloc = getBloc<B>(context);
      Dispatcher().registerView(_bloc, this);
      return _bloc.streams;
    } catch (e) {
      debugPrint("Error: Not found BloC to be registered.\n"
          "Create widget using:\n"
          "$this().create()");
      return null;
    }
  }

  void dispatch(EventsBase event) {
    Dispatcher().dispatch(this, event);
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
 *  Widget create(){
      return BlocProvider<BlocBase,StreamsBase>(
        child: this,
      );
    }

    no StatefulWidget
 */

mixin BlocViewMixin<B extends BlocBase, S extends StreamsBase>
    implements BlocView<EventsBase> {

  final String _uuidView =
      "${DateTime.now().millisecondsSinceEpoch.toString()}-view";

  @override
  set uuid(String _uuid) {}

  @override
  String get uuid => _uuidView;

  @protected
  Widget buildView(BuildContext context, S streams);

  Widget build(BuildContext context) {
    var streams = _initBlocView(context);
    return buildView(context, streams);
  }

  S _initBlocView(BuildContext context) {
    try {
      var _bloc = getBloc<B>(context);
      Dispatcher().registerView(_bloc, this);
      return _bloc.streams;
    } catch (e) {
      debugPrint("Error: Not found BloC to be registeredo.\n"
          "Create widget using:\n"
          "return BlocProvider<$B,$S>(\n"
          "  child: Widget(),\n"
          ");");
      return null;
    }
  }

  void dispatch(EventsBase event) {
    Dispatcher().dispatch(this, event);
  }

  T getBloc<T extends BlocBase>(BuildContext context) {
    return Provider.of<T>(context);
  }
}
