import 'package:flutter/material.dart';

@immutable
class ValueSnapshot<T> {
  const ValueSnapshot(this.data) : assert(data != null);
  final T data;
}

typedef ValueWidgetBuilder<T> = Widget Function(
    BuildContext context, ValueSnapshot<T> snapshot);

class StreamListener<T> extends StatelessWidget {
  final Stream stream;
  final ValueWidgetBuilder<T> builder;
  final Widget Function(BuildContext) contentEmptyBuilder;

  StreamListener({Key key, this.stream, this.builder, this.contentEmptyBuilder})
      : assert(stream != null, builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, ValueSnapshot(snapshot.data));
        }
        return _buildEmpty(context);
      },
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return contentEmptyBuilder != null
        ? contentEmptyBuilder(context)
        : Container(
            width: 0.0,
            height: 0.0,
          );
  }
}
