import 'package:bsev/stream_create.dart';
import 'package:flutter/material.dart';

@immutable
class ValueSnapshot<T> {
  const ValueSnapshot(this.data) : assert(data != null);
  final T data;
}

typedef ValueWidgetBuilder<T> = Widget Function(
    BuildContext context, ValueSnapshot<T> snapshot);

class StreamListener<T> extends StatelessWidget {
  final StreamCreate<T> stream;
  final ValueWidgetBuilder<T> builder;
  final Widget Function(BuildContext) contentEmptyBuilder;
  final bool animate;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  StreamListener(
      {Key key,
      this.stream,
      this.builder,
      this.contentEmptyBuilder,
      this.animate = true,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder})
      : assert(stream != null, builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream.get,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: animate ? 300 : 0),
          transitionBuilder: transitionBuilder,
          child: snapshot.hasData
              ? builder(context, ValueSnapshot(snapshot.data))
              : _buildEmpty(context),
        );
      },
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return contentEmptyBuilder != null
        ? contentEmptyBuilder(context)
        : SizedBox.shrink();
  }
}
