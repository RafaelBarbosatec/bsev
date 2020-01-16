
import 'package:flutter/material.dart';

@immutable
class ValueSnapshot<T> {
  const ValueSnapshot(this.data)
      :assert(data != null);
  final T data;
}

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, ValueSnapshot<T> snapshot);

class StreamListener<T> extends StatelessWidget {

  final Stream stream;
  final ValueWidgetBuilder<T> builder;
  final Widget contentEmpty;

  StreamListener({Key key, this.stream, this.builder, this.contentEmpty}) :assert(stream != null,builder != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return builder(context,ValueSnapshot(snapshot.data));
        }
        return _buildEmpty();
      },
    );
  }

  Widget _buildEmpty() {
    return contentEmpty != null ? contentEmpty : Container();
  }

}