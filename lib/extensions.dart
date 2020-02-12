import 'package:bsev/bsev.dart';
import 'package:bsev/stream_create.dart';
import 'package:flutter/cupertino.dart';

extension Streamcreate on StreamCreate {
  Widget builder<T>(Widget Function(T) build,
      {Widget Function(BuildContext) buildEmpty}) {
    return StreamListener<T>(
      stream: this,
      contentEmptyBuilder: buildEmpty,
      builder: (context, snapshot) {
        return build(snapshot.data);
      },
    );
  }
}
